class Inquiry < ActionMailer::Base
  default from: 'Tradewinds Cottage <info@tradewindscottage.net>'

  def new_inquiry(contact)
    @contact = contact
    mail(to: 'Brianna <brianna@tradewindscottage.net>, Ryan <arebuckley@gmail.com>', subject: 'New inquiry for the Tradewinds Cottage!')
  end

end
