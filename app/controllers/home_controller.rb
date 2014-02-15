class HomeController < ApplicationController
  def index
    @contact = Contact.new
  end

  def photos
    render partial: 'photos'
  end
end