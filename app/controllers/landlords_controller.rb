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
    @color_func = lambda do |rating|
      case rating
      when (3.5..5)
        'greenback'
      when (2..3.4)
        'yellowback'
      else
        'redback'
      end
    end
	end

  def destroy
    landlord = Landlord.find(params[:id])
    landlord.destroy if landlord
    redirect_to landlords_path
  end
end
