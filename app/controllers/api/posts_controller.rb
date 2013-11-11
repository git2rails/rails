class Api::PostsController < Api::ApiController

  rescue_from ActiveRecord::RecordNotFound do
    respond_to do |format|
      format.json { render :nothing => true, :status => 200 }
    end
  end

  def index
    @page = params[:page] || 1
    @per_page = params[:per_page] || 20
    @posts = Post.active.where(app_id: params[:app_id]).paginate(page: @page, per_page: @per_page).order('id DESC')
    respond_to do |format|
      format.json { render json: to_json(ResultCode::SUCCESS, "OK", {posts: @posts.to_json(:include => { :user => { :only => :name }, :comments =>{ :only => :comment} })}), status: 200 }
    end
  end


  def new
   @post = Post.new()
   respond_to do |format|
     format.json { render json: to_json(ResultCode::SUCCESS, "OK", @post.to_json), status: 200 }
   end
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      respond_to do |format|
        format.json { render json: to_json(ResultCode::SUCCESS, "OK", @post.to_json), status: 200 }
      end
    else 
      respond_to do |format|
        format.json { render json: to_json(ResultCode::INVALID_MODEL, @post.errors, @post.to_json), status: 200 }
      end
    end 
  end

  def edit
    find_current_user_post(parmas[:id])
    respond_to do |format|
      format.json { render json: to_json(ResultCode::SUCCESS, "OK", @post.to_json), status: 200 }
    end
  end

  def update
    find_current_user_post(parmas[:id])
    raise(ActiveRecord::RecordNotFound.new) unless @post
    if @post.update(post_params)
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
    find_current_user_post(parmas[:id])
    raise(ActiveRecord::RecordNotFound.new) unless @post
    @post.enabled = false
    if @post.save
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
    def post_params
      params.require(:post).permit(:app_id, :type, :content)
    end
    
    def find_post(id)
      @post = Post.find_by_id_and_visible_and_enabled(id, true, true)
    end

    def find_current_user_post(id)
      @post = current_user.posts.find(id)
    end
end
