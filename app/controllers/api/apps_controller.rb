class Api::AppController < Api::ApiController
  before_action :set_app, only: [:show]

  def index
    apps = App.paginate(:page => params[:page]).order('created_at DESC')
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
