class InquiryMailer < ActionMailer::Base

  def new_inquiry
    mail(to: "Ryan <ryan@dontspreadit.com>", subject: "New inquiry for the Tradewinds Cottage!", from: "arebuckley@gmail.com")
  end

end
