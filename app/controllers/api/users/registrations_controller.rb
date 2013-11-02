class Api::Users::RegistrationsController < Api::ApiController

  wrap_parameters User
  before_filter :authenticate_user!, :except =>[:create]

  def create
    user = User.new(user_params)
    if user.save
      render :json=> user.as_json(:only => [:name, :authentication_token]), :status=>201
      return
    else
      warden.custom_failure!
      render :json=> user.errors, :status=>422
    end
  end

  def user_params
    params.require(:user).permit(:name)
  end

end
