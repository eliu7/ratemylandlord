#Controller to handle user ratings
class RatingsController < ApplicationController
  def new
    if require_sign_in
      @landlord = Landlord.find(params[:id]) if params[:id]
    end
  end

  def create
    id = params[:id]
    unless id
      landlord = Landlord.new
      landlord.name = params[:landlord][:name]
      landlord.rating_count = 0
      landlord.average_rating = 0
      landlord.save
      id = landlord.id
    end

    info = params[:rating]

    rating = Rating.new
    rating.user_id = current_user.id
    rating.landlord_id = id
    Rating.categories.each do |cat|
      rating[cat] = info[cat].to_i
    end
    rating.comment = info[:comment]
    rating.save

    redirect_to landlord_path(id: id)
  end
  def destroy
    rating = Rating.find(params[:id])
    lid = rating.landlord_id
    rating.destroy
    redirect_to landlord_path(:page => 1, :id => lid)
  end
end
