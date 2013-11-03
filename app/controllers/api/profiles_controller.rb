class Api::ProfilesController < Api::ApiController

  wrap_parameters User

  def update
    if current_user.update(user_params)
      render :json=> {:success=>true}
    else 
      render :json=> current_user.errors, :status=>422
    end 
  end

  def update_avatar
    current_user.avatar = params[:file]
    if current_user.save
      render :json => { :success=>true, 
        :avatar_url => {
          :original => current_user.avatar.url,
          :medium   => current_user.avatar.url(:medium),
          :thumb    => current_user.avatar.url(:thumb)
        }
      }
    else
      render :json=> current_user.errors, :status=>422
    end
  end

  def update_email_password
    if current_user.update(user_email_password_params)
      render :json=> {:success=>true}
    else 
      render :json=> current_user.errors, :status=>422
    end 

  private
    def user_params
      params.require(:user).permit(:sex, :birthday, :intro, :city, :sns, :setting)
    end

    def user_email_pasword_params
      params.require(:user).permit(:email, :password)
    end

end
