class HomeController < ApplicationController
  def index
    @contact = Contact.new
    @first_availability = Calendar.last && Calendar.last.available_dates.first
    @first_availability = Date.parse(@first_availability) rescue Date.today
  end
end