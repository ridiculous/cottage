module ApplicationHelper

  def mobile_device?
    params[:m] == '1' || request.user_agent =~ /Mobile|webOS/
  end

end
