class AboutController < ApplicationController
  def index
    @about_text = Text.about
    @about_text = @about_text.text
  end

  def edit
    if require_admin about_path
      @about_text = Text.about.text
    end
  end

  def update
    @about = Text.about
    @about.text = params[:about][:text]
    @about.save
    redirect_to about_path
  end
end
