class ContactController < ApplicationController
  def index
  end
  def create
    message = Message.new(params[:message])
    if message.deliver
      redirect_to root_path, :notice => 'Contact form successfully sent!'
    else
      redirect_to root_path, :notice => 'There was an error while sending the form please try again'
    end
  end
end
