class Contact < ActiveRecord::Base
  attr_accessor :device_type
  validates :email, :format => {:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create}
  validates :name, :arrival_date, :departure_date, presence: true
  validate :valid_arrival
  validate :spam

  def message_for_email
    if message.present?
      message.strip.chomp
    else
      'Not provided.'
    end
  end

  def valid_arrival
    if arrival_date && arrival_date < Date.today
      errors.add(:arrival_date, "should be in the future")
    end
  end

  def spam
    if device_type.present?
      errors.add(:base, "Bug off")
    end
  end
end
