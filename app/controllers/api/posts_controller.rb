class Api::PostController < Api::ApiController

  def create
    post = Post.new(post_params)
    post.user_id = current_user.id
    if post.save
      render :json=> {:success=>true}
    else 
      render :json=> post.errors, :status=>422
    end 
  end

  def update
    post = Post.find(params[:id])
    if post.update(post_params)
      render :json=> {:success=>true}
    else 
      render :json=> post.errors, :status=>422
    end 
  end

  def create_comment
    post = Post.find(params[:post_id])
    post.comments.create(:comment => params[:comment])
    if post.comments.create(:comment => params[:comment])
      render :json=> {:success=>true}
    else 
      render :json=> post.comments.errors, :status=>422
    end
  end

  private
    def post_params
      params.require(:post).permit(:app_id, :contents)
    end

end
