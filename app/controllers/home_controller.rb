class HomeController < ApplicationController
  def index
    @contact = Contact.new
    dates = Calendar.latest.try(:available_dates)
    @availability = VRBO::Availability.new(dates)
  end

  def photos
    render partial: 'photos'
  end
end