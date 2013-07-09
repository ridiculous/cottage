class CalendarController < ApplicationController
  def create
    arrival = Date.parse(convert_date(params[:arrival_date])) rescue nil
    depart = Date.parse(convert_date(params[:departure_date])) rescue nil
    errors = []
    if !arrival
      errors << 'Please enter an arrival date'
    elsif !depart
      errors << 'Please enter a departure date'
    elsif arrival > depart
      errors << 'Departure date should be later than arrival date'
    elsif arrival < Date.today
      errors << 'You should really plan for a trip in the future instead of the past'
    end

    if errors.blank?
      Calendar.refresh_available_dates if !Calendar.last || Calendar.last.refresh_date < 30.minutes.ago
      render json: Calendar.check_availability(arrival, depart), status: :ok
    else
      render json: errors.first, status: :unprocessable_entity
    end
  rescue
    render json: 'Oops! Something went wrong', status: :internal_server_error
  end
end
