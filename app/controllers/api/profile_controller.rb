class Api::ProfileController < Api::ApiController

  wrap_parameters User

  def update
    puts current_user.to_json
    current_user.name = params[:user][:name]
    if current_user.save
      render :json=> {:success=>true}
    else 
      render :json=> current_user.errors, :status=>422
    end 
  end

  private
    def user_params
      params.require(:user).permit(:name)
    end

end
