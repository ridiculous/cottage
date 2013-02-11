require 'mechanize'
require 'uri'
require 'net/https'

class Calendar < ActiveRecord::Base
  attr_accessible :available_dates, :refresh_date

  serialize :available_dates, Array

  before_create :set_refresh_date
  before_save :set_refresh_date

  class << self

    def check_availability(arrival, depart)
      available_dates = last.available_dates
      available = true
      arrival.upto(depart).each do |date|
        available = false if available_dates.exclude?(date.to_s)
      end
      available
    end

    def refresh_available_dates
      agent = Mechanize.new do |a|
        a.user_agent_alias = 'Mac Safari'
        a.redirection_limit = 100
        a.follow_meta_refresh = true
      end
      calendar = agent.get('https://www.homeawayconnect.com/calendar.cfm?pid=51970')

      # map out available dates and save to DB as array
      today = Date.today
      last_day = today + 1.year
      available_dates = []
      today.upto(last_day).each do |date|
        month = date.month.to_s.length == 1 ? "0#{date.month}" : date.month.to_s
        table_cells = calendar.search("#calMonthAvail#{date.year}#{month}").search('td.ACADV, td.ACWDV')
        available_dates << date.to_s if table_cells && table_cells.map { |cell| cell.children.to_s }.include?(date.day.to_s)
      end
      delete_all
      create(available_dates: available_dates)
    end

  end

  private

  def set_refresh_date
    self.refresh_date = Time.now
  end
end
