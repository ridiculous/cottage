class Inquiry < ActionMailer::Base
  default :from => 'System - Tradewinds Cottage <info@tradewindscottage.net>'
  # Brianna <brianna@tradewindscottage.net
  def new_inquiry(contact)
    @contact = contact
    mail(to: "Ryan <arebuckley@gmail.com>", subject: "New inquiry for the Tradewinds Cottage!")
  end

end
