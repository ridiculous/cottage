class ContactController < ApplicationController
  def create
    redirect_to root_path, notice: 'yay'
  end
end
