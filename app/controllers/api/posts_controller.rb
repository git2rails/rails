class Api::PostController < Api::ApiController

  rescue_from ActiveRecord::RecordNotFound do
    respond_to do |format|
      format.json { render :nothing => true, :status => 200 }
    end
  end

  def create
    post = Post.new(post_params)
    post.user_id = current_user.id
    if post.save
      respond_to do |format|
        format.json { render :nothing => true, :status => 200 }
      end
    else 
      respond_to do |format|
        format.json { render :nothing => true, :status => 200 }
      end
    end 
  end

  def update
    find_post
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
    if @post.user_id != currnet_user.id
      respond_to do |format|
        format.json { render :nothing => true, :status => 200 }
      end
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
      params.require(:post).permit(:app_id, :contents)
    end
    
    def find_post(id)
      @post = Post.find_by_id_and_visible_and_enabled(id, true, true)
    end

    def find_current_user_post(id)
      @post = current_user.posts.find(id)
    end


end
