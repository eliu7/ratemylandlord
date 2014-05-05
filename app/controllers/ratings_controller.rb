class RatingsController < ApplicationController
  def new
  end

  def create
    id = params[:id]
    if id.nil?
      landlord = Landlord.new
      landlord.name = params[:name]
      landlord.save
      id = landlord.id
    end

    rating = Rating.new
    rating.user_id = current_user.id
    rating.landlord_id = id
    Rating.categories.each do |cat|
      rating[cat] = params[cat].to_i
    end
    rating.comment = params[:comment]
    rating.save

    redirect_to landlord_path(id: id)
  end
end
