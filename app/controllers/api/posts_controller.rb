class Api::PostsController < Api::ApiController

  rescue_from ActiveRecord::RecordNotFound do
    respond_to do |format|
      format.json { render :nothing => true, :status => 200 }
    end
  end

  def index
    @posts = Post.where(app_id: params[:app_id], visible:true, enabled:true).paginate(page: params[:page], per_page: 5).order('id DESC')
    respond_to do |format|
      format.json { render json: to_json(200, "OK", @posts.to_json), status: 200 }
    end
  end

  def show
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      respond_to do |format|
        format.json { render json: to_json(200, "OK", @post.to_json), status: 200 }
      end
    else 
      respond_to do |format|
        format.json { render json: to_json(400, @post.errors, @post.to_json), status: 200 }
      end
    end 
  end

  def update
    find_current_user_post
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
    find_current_user_post
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
      params.require(:post).permit(:app_id, :content)
    end
    
    def find_post(id)
      @post = Post.find_by_id_and_visible_and_enabled(id, true, true)
    end

    def find_current_user_post(id)
      @post = current_user.posts.find(id)
    end
end
