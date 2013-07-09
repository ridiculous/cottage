class HomeController < ApplicationController
  def index
    @contact = Contact.new
    @availability = Calendar::Availability.new(Date.today, 1, [])
    dates = Calendar.last && Calendar.last.available_dates
    if dates.try(:any?)
      @availability.first = Date.parse(dates.shift)
      @availability.duration = dates.each_with_index.sum do |the_date, i|
        Date.parse(the_date) - (@availability.first + i.days) == 1 ? 1 : 0
      end + 1
    else
      @availability.errors << 'Maybe...'
    end
  end
end