class Api::RatingsController < Api::ApiController

  rescue_from ActiveRecord::RecordNotFound do
    respond_to do |format|
      format.json { render :nothing => true, :status => 200 }
    end
  end

  def index
    @page = params[:page] || 1
    @per_page = params[:per_page] || 20
    @ratings = Rating.active.where(app_id: params[:app_id]).paginate(page: @page, per_page: @per_page).order('id DESC')
    respond_to do |format|
      format.json { render json: to_json(ResultCode::SUCCESS, "OK", {ratings: @ratings.to_json(:include => { :user => { :only => :name } })}), status: 200 }
    end
  end


  def create
    @rating = Rating.new(rating_params)
    @rating.user_id = current_user.id
    if @rating.save
      respond_to do |format|
        format.json { render json: to_json(ResultCode::SUCCESS, "OK", @rating.to_json), status: 200 }
      end
    else 
      respond_to do |format|
        format.json { render json: to_json(400, @rating.errors, @rating.to_json), status: 200 }
      end
    end 
  end

  def show
    find_current_user_rating(params[:id])
    if !@rating 
      @rating = Rating.new()
    end 
    respond_to do |format|
      format.json { render json: to_json(ResultCode::SUCCESS, "OK", @rating.to_json), :status => 200 }
    end
  end    

  def update
    find_current_user_rating(params[:id])
    if !@rating 
       @rating = Rating.new(rating_params)
       @rating.user_id = current_user.id
       if @rating.save
          respond_to do |format|
            format.json { render json: to_json(ResultCode::SUCCESS, "OK", @rating.to_json), status: 200 }
          end
       else 
          respond_to do |format|
            format.json { render json: to_json(400, @rating.errors, @rating.to_json), status: 200 }
          end
       end
    end
    
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
    find_current_user_rating(parmas[:id])
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
