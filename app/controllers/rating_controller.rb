class RatingController < ApplicationController
  def index
    if (params[:id])
      @ratings = Rating.where(landlord_id: params[:id])
    else
      @ratings = Rating.all
    end
  end

  def create
    @rating = Rating.create!(params[:rating])
    flash[:notice] = "Rating created"
    redirect_to ratings_path(id: @rating.landlord_id)
  end

  def new
  end

  def destroy
    @rating = Rating.find(params[:id])
    @rating.destroy
    flash[:notice] = "Rating removed"
    redirect_to ratings_path(id: @rating.landlord_id)
  end
end
