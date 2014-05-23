#Controller for the landlord list and each individual landlord page
class LandlordsController < ApplicationController
  def index
    pagesize = 20
    @page = (params[:page] || '1').to_i
    @sort = params[:sort]
    @search = params[:search]
    @search = nil if @search && @search.empty?
    if (@sort && @sort != 'Relevence') || (@sort.nil? && @search.nil?)
      @sort||='Name A-Z'
      sorts = {'Name A-Z' => ['name ASC'], 'Name Z-A' => ['name DESC'],
               'Best Rating' => ['average_rating DESC', 'name ASC'],
               'Worst Rating' => ['average_rating ASC', 'name DESC']}
      @landlords = Landlord.order(*sorts[@sort])
    end
    if @search
      if @landlords
        @landlords = Landlord.search_from(@search, @landlords)
        @count = @landlords.count
        @landlords = @landlords.limit(pagesize).offset((@page-1)*pagesize)
      else
        @sort = 'Relevence'
        @landlords = Landlord.search(@search)
        @count = @landlords.count
        @landlords = @landlords.drop((@page-1)*pagesize).take(pagesize)
      end
    else
      @count = @landlords.count
      @landlords = @landlords.limit(pagesize).offset((@page-1)*pagesize)
    end
    @page_count = (@count-1)/pagesize+1

    @range = [((@page-1)*pagesize+1),@count].min..[@page*pagesize, @count].min

    @sorts = ['Name A-Z', 'Name Z-A', 'Best Rating', 'Worst Rating']
    @sorts.unshift('Relevence') if @search
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
    pagesize = 10
    landlord_id = params[:id]
    @page = (params[:page] || '1').to_i
    @mylandlord = Landlord.find(landlord_id)
    @reviews = @mylandlord.ratings(@page)
    @avg_reviews=@mylandlord.average_ratings
    @count = @mylandlord.rating_count
    @page_count = (@count-1)/pagesize+1
    @user_id = current_user.id if current_user
    @rated = current_user && Rating.where(landlord_id: landlord_id, user_id: @user_id).first
    logger.info "Page #{@page} Count #{@page_count}"
    @range = [((@page-1)*pagesize+1),@count].min..[@page*pagesize, @count].min
  end

  def destroy
    landlord = Landlord.find(params[:id])
    landlord.destroy
    redirect_to landlords_path
  end
end
