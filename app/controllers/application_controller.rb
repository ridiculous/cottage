class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from ActionController::RoutingError, with: :go_home

  private

  def convert_date(the_date)
    the_date.gsub(%r{(\d{2})/(\d{2})/(\d+)}, '\3-\1-\2')
  end

  def go_home
    redirect_to root_path
  end
end
