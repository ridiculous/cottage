class Inquiry < ActionMailer::Base
  default from: 'Tradewinds Cottage <info@tradewindscottage.net>'

  def new_inquiry(contact)
    @contact = contact
    @date_range = DateRange.new(@contact.arrival_date, @contact.departure_date)
    siblings = 'Ryan <arebuckley@gmail.com>'
    siblings << ', Brianna <brianna@tradewindscottage.net>' unless Rails.env.development?
    mail(to: siblings, subject: 'New inquiry for the Tradewinds Cottage!')
  end

end
