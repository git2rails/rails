class Api::ProfileController < Api::ApiController

  wrap_parameters User

  def update
    print user_params
    if current_user.update(user_params)
      render :json=> {:success=>true}
    else 
      render :json=> current_user.errors, :status=>422
    end 
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end
