class Api::RatingsController < Api::ApiController

  rescue_from ActiveRecord::RecordNotFound do
    respond_to do |format|
      format.json { render :nothing => true, :status => 200 }
    end
  end

  def index
    @ratings = Rating.active.where(app_id: params[:app_id]).paginate(page: params[:page], per_page: 20).order('id DESC')
    respond_to do |format|
      format.json { render json: to_json(200, "OK", {ratings: @ratings.to_json(:include => { :user => { :only => :name } })}), status: 200 }
    end
  end


  def create
    @rating = Rating.new(rating_params)
    @rating.user_id = current_user.id
    if @rating.save
      respond_to do |format|
        format.json { render json: to_json(200, "OK", @rating.to_json), status: 200 }
      end
    else 
      respond_to do |format|
        format.json { render json: to_json(400, @rating.errors, @rating.to_json), status: 200 }
      end
    end 
  end

  def update
    find_current_user_rating
    raise(ActiveRecord::RecordNotFound.new) unless @rating
    if @rating.update(rating_params)
      respond_to do |format|
        format.json { render :nothing => true, :status => 200 }
      end
    else 
      respond_to do |format|
        format.json { render :nothing => true, :status => 200 }
      end
    end 
  end

  def destroy
    find_current_user_rating
    raise(ActiveRecord::RecordNotFound.new) unless @rating
    @rating.enabled = false
    if @rating.save
      respond_to do |format|
        format.json { render :nothing => true, :status => 200 }
      end
    else 
      respond_to do |format|
        format.json { render :nothing => true, :status => 200 }
      end
    end 
  end


  private
    def rating_params
      params.require(:rating).permit(:app_id, :starts, :comment)
    end
    
    def find_rating(id)
      @rating = Rating.find(id)
    end

    def find_current_user_rating(id)
      @rating = current_user.ratings.find(id)
    end
end
