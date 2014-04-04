class CalendarController < ApplicationController
  def create
    date_range = DateRange.new(params[:arrival_date], params[:departure_date])
    date_range.to_date!

    if date_range.valid?
      if Calendar.outdated?
        Calendar.create(available_dates: VRBO::Calendar.find_available_dates)
      end
      render json: date_range.open?, status: :ok
    else
      render json: date_range.errors.first, status: :unprocessable_entity
    end

  rescue
    render json: 'Oops! Something went wrong', status: :internal_server_error
  end
end
