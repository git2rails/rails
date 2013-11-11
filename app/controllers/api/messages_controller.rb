class Api::MessagesController < Api::ApiController
  
  def create
    ActiveRecord::Base.transaction do
      args = message_params
      args[:user_id] = current_user.id
      args[:sent] = true
      args[:enabled] = true
      
      msg_of_sender = Message.new(args)
      if !msg_of_sender.save
        respond_to do |format|
          format.json { render json: to_json(ResultCode::ERROR, "failed saving message of sender", {}), status: 200 }
        end
        return  
      end
      
      args[:user_id] = args[:opponent_id]
      args[:opponent_id] = current_user.id
      args[:sent] = false
      
      msg_of_recipient = Message.new(args)
      if !msg_of_recipient.save
        respond_to do |format|
          format.json { render json: to_json(ResultCode::ERROR, "failed saving message of recipient", {}), status: 200}
        end
        return
      end      
      
      respond_to do |format|
        format.json { render json: to_json(ResultCode::SUCCESS, "",{}), status: 200 }
      end
    end
  end
  
  def destroy
    message = current_user.messages.find_by(message_params)
    raise(ActiveRecord::RecordNotFound.new) unless message

    if current_user.id != message.user_id
      respond_to do |format|
        format.json { render json: to_json(ResultCode::ERROR, "", {}), status: 200 } 
      end 
      return
    end
    
    message.enabled = false
    if message.update(message_params)
      respond_to do |format|
        format.json { render json: to_json(ResultCode::SUCCESS, "", {}), status: 200 }
      end
    else
      respond_to do |format|
        format.json { render json: to_json(ResultCode::SUCCESS, "", {}), status: 200 }
      end
    end
  end
  
  def get_messages
    page = params[:page].to_i.to
        
    messages = current_user.messages.order(create_at: :desc).limit(10).offset((page-1)*10)
    respond_to do |format|
      format.json { render json: to_json(ResultCode::SUCCESS, "", messages), status: 200}
    end
  end
  
  private
    def message_params
      params.require(:message).permit(:id, :user_id, :opponent_id, :text, :sent, :enabled)
    end
  
end
