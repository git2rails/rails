class Api::ProfilesController < Api::ApiController

  def update
    if current_user.update(user_params)
      respond_to do |format|
        format.json { render json: to_json(ResultCode::SUCCESS, "", {}), status: 200 }
      end
    else
      respond_to do |format|
        format.json { render json: to_json(ResultCode::ERROR, "", current_user.errors), status: 200 }
      end
    end 
  end

  def update_avatar
    current_user.avatar = params[:file]
    if current_user.save
        respond_to do |format|
          format.json { render json: to_json(ResultCode::SUCCESS, "",
            avartar_url = {
              :original => current_user.avatar.url,
              :medium   => current_user.avatar.url(:medium),
              :thumb    => current_user.avatar.url(:thumb)              
            }), status: 200
          }
        end
    else
      respond_to do |format|
        format.json { render json: to_json(ResultCode::ERROR, "", current_user.errors), status: 200 }
      end      
    end
  end

  def update_email_password
    if current_user.update(user_email_password_params)
      respond_to do |format|
        format.json { render json: to_json(ResultCode::SUCCESS, "", {}), status: 200 }
      end      
    else
      respond_to do |format|
        format.json { render json: to_json(ResultCode::ERROR, "", current_user.errors), status: 200 }
      end      
    end
  end 

  private
    def user_params
      params.require(:user).permit(:sex, :birthday, :intro, :city, { sns: [:kakao, :line] }, :setting)
    end

    def user_email_password_params
      params.require(:user).permit(:email, :password)
    end

end