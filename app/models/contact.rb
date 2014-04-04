class Contact < ActiveRecord::Base

  validates :email, :format => {:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create}
  validates :name, :arrival_date, :departure_date, presence: true

  def message_for_email
    if message.present?
      message.strip.chomp
    else
      'Not provided.'
    end
  end
end
