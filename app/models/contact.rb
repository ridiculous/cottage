class Contact < ActiveRecord::Base
  attr_accessible :name, :number_of_people, :email, :address, :phone, :arrival_date, :departure_date, :message
  validates :email, :format => {:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create}
  validates :name, :arrival_date, :departure_date, presence: true
end
