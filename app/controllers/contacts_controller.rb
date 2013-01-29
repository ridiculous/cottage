class ContactsController < ApplicationController

  require 'mechanize'
  require 'uri'
  require 'net/https'

  def new
    contact_params = params[:contact]
    arrival = convert_date(contact_params[:arrival_date])
    depart = convert_date(contact_params[:departure_date])
    errors = []
    errors << 'Please enter an arrival and departure date' if !arrival || !depart
    errors << 'Departure date should be later than arrival date' if arrival > depart
    errors << 'You should really plan for a trip in the future instead of the past' if arrival < Date.today

    agent = Mechanize.new do |a|
      a.user_agent_alias = 'Mac Safari'
      a.redirection_limit = 100
      a.follow_meta_refresh = true
    end

    calendar = agent.get('https://www.homeawayconnect.com/calendar.cfm?pid=51970')
    calendar.search('#calMonthAvail201302')
    r_years = [arrival, depart].map { |x| x.year }.uniq
    r_months = [arrival, depart].map { |x| x.month }.uniq

    table_cells = calendar.search('#calMonthAvail201302').search('.ACUDV, .ACWDV')
    t = table_cells.search('td').search(':contains(29)')
    t.first.attributes['class'].value
  end

  def create
    contact_params = params[:contact]
    @contact = Contact.new(contact_params)
    @contact.departure_date = convert_date(contact_params[:departure_date])
    @contact.arrival_date = convert_date(contact_params[:arrival_date])

    if @contact.save
      Inquiry.new_inquiry(@contact).deliver
      render json: nil, status: :created
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  private

  def convert_date(the_date)
    the_date.gsub(%r{(\d{2})/(\d{2})/(\d+)}, '\3-\1-\2')
  end

end
