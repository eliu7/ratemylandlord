class ContactController < ApplicationController
  def index
    @contact_text = Text.contact
    @contact_text = @contact_text.text
  end

  def edit
    if require_admin contact_path
      @contact_text = Text.contact.text
    end
  end

  def update
    @contact = Text.contact
    @contact.text = params[:contact][:text]
    @contact.save
    redirect_to contact_path
  end
end
