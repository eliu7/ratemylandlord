class LandlorddetailsController < ApplicationController
	def landlord
		landlord_id = 1 #params[:id]
		pagenum = params[:page] || 1
		@mylandlord = Landlord.find(landlord_id)
		@reviews = @mylandlord.ratings
		@avg_reviews=@mylandlord.average_ratings
	end
end
