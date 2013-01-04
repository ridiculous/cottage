class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from ActionController::RoutingError, with: :go_home


  private

  def go_home
    redirect_to root_path
  end
end
