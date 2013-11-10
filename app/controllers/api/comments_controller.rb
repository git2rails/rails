class Api::CommentsController < Api::ApiController

  rescue_from ActiveRecord::RecordNotFound do
    respond_to do |format|
      format.json { render :nothing => true, :status => 200 }
    end
  end

  def index
    @page = params[:page] || 1
    @per_page = params[:per_page] || 20
    @comments = Comment.active.where(post_id: params[:post_id]).paginate(page: @page, per_page: @per_page).order('id DESC')
    respond_to do |format|
      format.json { render json: to_json(ResultCode::SUCCESS, "OK", {comments: @comments.to_json(:include => { :user => { :only => :name } })}), status: 200 }
    end
  end

  def show
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      respond_to do |format|
        format.json { render json: to_json(ResultCode::SUCCESS, "OK", @comment.to_json), status: 200 }
      end
    else 
      respond_to do |format|
        format.json { render json: to_json(ResultCode::INVALID_MODEL, @comment.errors, {}), status: 200 }
      end
    end 
  end

  def update
    find_current_user_comment(parmas[:id])
    raise(ActiveRecord::RecordNotFound.new) unless @comment
    if @comment.update(post_params)
      respond_to do |format|
        format.json { render json: to_json(ResultCode::SUCCESS, "OK", @comment.to_json), status: 200 }
      end
    else 
      respond_to do |format|
        format.json { render json: to_json(ResultCode::INVALID_MODEL, @comment.errors, {}), status: 200 }
      end
    end 
  end

  def destroy
    find_current_user_comment(parmas[:id])
    raise(ActiveRecord::RecordNotFound.new) unless @comment
    @comment.enabled = false
    if @comment.save
      respond_to do |format|
        format.json { render json: to_json(ResultCode::SUCCESS, @comment.errors, {}), status: 200 }
      end
    else 
      respond_to do |format|
        format.json { render json: to_json(ResultCode::INVALID_MODEL, @comment.errors, {}), status: 200 }
      end
    end 
  end


  private
    def comment_params
      params.require(:comment).permit(:post_id, :comment)
    end
    
    def find_comment(id)
      @comment = Comment.active.find(id)
    end

    def find_current_user_comment(id)
      @comment = current_user.comment.active.find(id)
    end
end
