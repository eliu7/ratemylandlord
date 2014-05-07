class RatingsController < ApplicationController
  def new
    if require_sign_in
      @landlord = Landlord.find(params[:id]) unless params[:id].nil?
    end
  end

  def create
    id = params[:id]
    if id.nil?
      landlord = Landlord.new
      landlord.name = params[:landlord][:name]
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
end
