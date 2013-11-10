class Api::AppsController < Api::ApiController
  before_action :set_app, only: [:show]

  def index
    @page = params[:page] || 1
    @per_page = params[:per_page] || 20
    @apps = App.paginate(page: @page, per_page: @per_page).order('created_at DESC')
    respond_to do |format|
      format.json { render json: to_json(ResultCode::INVALID_MODEL, "OK", {apps: @apps.to_json}), status: 200 }
    end
  end

  def show
    render :json=> {:success=>true}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_app
      @app = App.find(params[:id])
    end
end
