class InquiryMailer < ActionMailer::Base
  default :from => 'info@tradewindscottage.net'
  # Brianna <brianna@tradewindscottage.net
  def new_inquiry(contact)
    @contact = contact
    mail(to: "Ryan <arebuckley@gmail.com>", subject: "New inquiry for the Tradewinds Cottage!")
  end

end
