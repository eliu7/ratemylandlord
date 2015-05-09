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
      name = params[:landlord][:name]
      landlord = Landlord.where(:name => name).first_or_initialize do |ll|
        logger.info '-------------------NEW LANDLORD------------------'
        ll.init(name)
        ll.save
      end
      id = landlord.id
    end

    info = params[:rating]

    rating = Rating.where(:landlord_id => id, :user_id => current_user.id).first
    if rating
      rating.skip_save_callback = true
      rating.update_info(info)
      rating.update_attributes!(info)
      rating.skip_save_callback = false
    else
      rating = Rating.new unless rating
      rating.user_id = current_user.id
      rating.landlord_id = id
      rating.oldreview = false # all new reviews set this false
      Rating.questions.each do |cat|
        rating[cat] = info[cat].to_i
      end
      rating.comment = info[:comment]
      rating.save
    end

    redirect_to landlord_path(:id => id)
  end

  def destroy
    rating = Rating.find_by_id(params[:id])
    if rating
      lid = rating.landlord_id
      rating.destroy
      redirect_to landlord_path(:page => 1, :id => lid)
    else
      redirect_to landlords_path
    end
  end

  def edit
    @rating = Rating.find(params[:id])
    if require_sign_in(@rating.user_id)
      @landlord = @rating.landlord
    end
  end

  def update
    @rating = Rating.find(params[:id])
    @rating.skip_save_callback = true
    logger.info "Rating params: #{params[:rating]}"
    @rating.update_info(params[:rating])
    @rating.update_attributes!(params[:rating])
    @rating.skip_save_callback = false
    redirect_to landlord_path(:id => @rating.landlord_id)
  end
end
