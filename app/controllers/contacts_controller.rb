class ContactsController < ApplicationController

  def create
    contact_params = params[:contact]
    @contact = Contact.new(contact_params)
    @contact.departure_date = convert_date(contact_params[:departure_date])
    @contact.arrival_date = convert_date(contact_params[:arrival_date])

    if @contact.save
      Inquiry.new_inquiry(@contact).deliver
      render json: nil, status: :created
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  private

  def convert_date(the_date)
    the_date.gsub(%r{(\d{2})/(\d{2})/(\d+)}, '\3-\1-\2')
  end

end
