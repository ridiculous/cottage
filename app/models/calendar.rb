require 'mechanize'
require 'uri'
require 'net/https'

class Calendar < ActiveRecord::Base
  attr_accessible :available_dates, :refresh_date

  serialize :available_dates, Array

  after_validation :set_refresh_date

  class << self

    def check_availability(arrival, depart)
      available_dates = last.available_dates
      available = true
      arrival.upto(depart - 1.day).each do |date|
        available = false if available_dates.exclude?(date.to_s)
      end
      available
    end

    def refresh_available_dates
      agent = Mechanize.new do |a|
        a.user_agent_alias = 'Mac Safari'
        a.redirection_limit = 10
        a.follow_meta_refresh = true
      end
      calendar = agent.get('https://www.homeawayconnect.com/calendar.cfm?pid=51970')
      transaction do
        # clear the table
        delete_all

        # map out available dates and save to DB as array
        today = Date.today
        tds = Hash.new
        create(available_dates: today.upto(today + 1.year).map { |date|
          m = date.month.to_s
          table_cells = calendar.search("#calMonthAvail#{date.year}#{m.length == 1 ? "0#{m}" : m}").search('td.ACADV, td.ACWDV')
          if table_cells
            tds[m] ||= table_cells.map { |cell| cell.children.to_s }
            date.to_s if tds[m].include?(date.day.to_s)
          end
        }.compact)
      end
    end

  end

  private

  def set_refresh_date
    self.refresh_date = Time.now
  end
end
