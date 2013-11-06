class Api::ApiController < ActionController::Base
  respond_to :json
  before_action :authenticate_user_from_token!
  # This is Devise's authentication
  before_action :authenticate_user!
 
  private
  
  def authenticate_user_from_token!
    authentication_token = request.headers["x-auth-token"].presence
    user       = authentication_token && User.find_by_authentication_token(authentication_token)
 
    # Notice how we use Devise.secure_compare to compare the token
    # in the database with the token given in the params, mitigating
    # timing attacks.
    if user && Devise.secure_compare(user.authentication_token, request.headers["x-auth-token"])
      sign_in user, store: false
    end
  end
end
