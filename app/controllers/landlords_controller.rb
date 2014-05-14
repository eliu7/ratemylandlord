#Controller for the landlord list and each individual landlord page
class LandlordsController < ApplicationController
  def index
    if params[:search]
      @landlords = Landlord.search(params[:search])
    else
      @landlords = Landlord.all
    end
  end

  def get_color(rating)
    case rating
    when (4.5..5)
      'greenback'
    when (3.1..4.4)
      'greenyellowback'
    when (2.1..3.0)
      'yellowback'
    when (1.5..2.0)
      'redyellowback'
    else
      'redback'
    end
  end

  def show
    landlord_id = params[:id]
    @pagenum = (params[:page] || '1').to_i
    @mylandlord = Landlord.find(landlord_id)
    @reviews = @mylandlord.ratings(@pagenum)
    @avg_reviews=@mylandlord.average_ratings
    numreviews =@mylandlord.ratings.count
    @pagetotal = (numreviews/10.0).ceil
    @user_id = current_user.id if current_user
    @rated = current_user && Rating.where(landlord_id: landlord_id, user_id: @user_id).first
  end

  def destroy
    landlord = Landlord.find(params[:id])
    Rating.where(landlord_id: landlord.id).destroy_all
    landlord.destroy
    redirect_to landlords_path
  end
end
