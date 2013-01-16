class InquiryMailer < ActionMailer::Base
  default :from => 'info@tradewindscottage.net'
  def new_inquiry(options={})
    mail(to: "Brianna <brianna@tradewindscottage.net", subject: "New inquiry for the Tradewinds Cottage!")
  end

end
