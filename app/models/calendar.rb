class Calendar < ActiveRecord::Base
  serialize :available_dates, Array

  after_validation :set_refresh_date

  class << self
    def check_availability(arrival, depart)
      VRBO::Calendar.new.available?(arrival, depart, latest.try(:available_dates))
    end

    def outdated?
      latest_record = latest
      !latest_record || latest_record.available_dates.blank? || latest_record.refresh_date < 45.minutes.ago
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
