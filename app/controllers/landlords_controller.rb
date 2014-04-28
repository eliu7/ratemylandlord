class LandlordsController < ApplicationController
  def index
    if params[:search] == nil
      @landlords = Landlord.all
    else
      @landlords = Landlord.search(params[:search])
    end
  end

	def show
		landlord_id = params[:id]
		pagenum = params[:page] || 1
		@mylandlord = Landlord.find(landlord_id)
		@reviews = @mylandlord.ratings(pagenum)
		@avg_reviews=@mylandlord.average_ratings
	end
end
