class ContactsController < ApplicationController

  def new
    # @contact instantiated in the HomeController instead
  end

  def create
    contact_params = params[:contact]
    @contact = Contact.new(contact_params)
    @contact.departure_date = DateRange.convert(contact_params[:departure_date])
    @contact.arrival_date = DateRange.convert(contact_params[:arrival_date])

    if @contact.save
      Inquiry.new_inquiry(@contact).deliver
      render json: nil, status: :created
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

end
