class HomeController < ApplicationController
  def index
    @contact = Contact.new(number_of_people: 2)
    @calendar = Calendar.latest || Calendar.new
    @calendar.available_dates.keep_if { |date| Date.parse(date) >= current_date }
    # @availability = VRBO::Availability.new @calendar.available_dates
  end

  def photos
    render partial: 'photos'
  end

  private

  def current_date
    @current_date ||= Date.current
  end
end