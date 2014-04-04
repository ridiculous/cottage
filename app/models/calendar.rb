class Calendar < ActiveRecord::Base
  serialize :available_dates, Array

  after_validation :set_refresh_date

  class << self
    def check_availability(arrival, depart)
      VRBO::Calendar.available?(arrival, depart, latest.try(:available_dates))
    end

    def outdated?
      !latest || latest.refresh_date < 45.minutes.ago
    end

    def latest
      order('id DESC').first
    end
  end

  private

  def set_refresh_date
    self.refresh_date = Time.now
  end
end
