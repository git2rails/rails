class Api::AppRankingsController < Api::ApiController

  rescue_from ActiveRecord::RecordNotFound do
    respond_to do |format|
      format.json { render :nothing => true, :status => 200 }
    end
  end

  def paid
    @app_rankings = AppRanking.top_selling_paid.where(paginate(page: params[:page], per_page: 20)).order('id DESC')
    respond_to do |format|
      format.json { render json: to_json(200, "OK", {posts: @app_rankings.to_json(:include => { :app => { :only => :name } })}), status: 200 }
    end
  end

  def free
    @app_rankings = AppRanking.top_selling_free.where(paginate(page: params[:page], per_page: 20)).order('id DESC')
    respond_to do |format|
      format.json { render json: to_json(200, "OK", {posts: @app_rankings.to_json(:include => { :app => { :only => :name } })}), status: 200 }
    end
  end

end
