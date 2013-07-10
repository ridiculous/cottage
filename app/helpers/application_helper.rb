module ApplicationHelper

  def mobile_device?
    params[:m] || request.user_agent =~ /Mobile|webOS/
  end

end
