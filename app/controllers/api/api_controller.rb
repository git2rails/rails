class Api::ApiController < ActionController::Base

  before_action :authenticate_user_from_token!
  
  # This is Devise's authentication
  before_filter :authenticate_user!


  class ResultCode
    SUCCESS       = 0
    ERROR         = 400
    INVALID_MODEL = 401
    INVALID_MODEL = 401
  end
 
  private
  
  def authenticate_user_from_token!
    authentication_token = request.headers["x-auth-token"].presence
    user = authentication_token && User.find_by_authentication_token(authentication_token)
 
    # Notice how we use Devise.secure_compare to compare the token
    # in the database with the token given in the params, mitigating
    # timing attacks.
    if user && Devise.secure_compare(user.authentication_token, request.headers["x-auth-token"])
      sign_in user, store: false
    end
  end
 
  def to_json(code, msg, body)
    return {header: {code: code, msg: msg}, body: body} 
  end

  def render_to_json
    render :json=> {
      :header=> {
        :code=> @code,
        :msg=> @msg
      },
      :body=> @body
    }
  end
end
