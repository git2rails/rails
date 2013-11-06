class Api::Users::UsersController < Api::ApiController
  
  wrap_parameters User
  before_filter :authenticate_user!, :except =>[:sign_up]
  
  def show
    render :json=> current_user
  end
 
  
  def user_params
    params.require(:user).permit(:name, :uuid, :phone)
  end
  
end
