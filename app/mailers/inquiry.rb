class Inquiry < ActionMailer::Base
  default from: 'Tradewinds Cottage <admin@tradewindscottage.net>'

  def new_inquiry(contact)
    @contact = contact
    @date_range = DateRange.new(@contact.arrival_date, @contact.departure_date)
    mail(to: 'Brianna <brianna@tradewindscottage.net>', subject: 'New inquiry for the Tradewinds Cottage!', bcc: 'Ryan <arebuckley@gmail.com>')
  end

end
