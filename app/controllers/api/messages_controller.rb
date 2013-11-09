class Api::MessagesController < ApplicationController
  
  def send
    recipient_id = params[:recipient_id]
    text = params[:text]
    
    msg_of_sender = Message.new(:user_id=> current_user.id, :opponent_id=> recipient_id, :text=> text, :sent=> true)
    
    if !msg_of_sender.save
      @code = "error"
      @msg = "failed saving message of sender"
      @body = {} 
      render_to_json
      return  
    end
    
    msg_of_recipient = Message.new(:user_id=> recipient_id, :opponent_id=> current_user.id, :text=> text, :sent=> false)
    if !msg_of_recipient.save
        @code = "error"
        @msg = "failed saving message of recipient"
        @body = {}
        render_to_json
        return
    end      
    
    @code = "ok"
    @msg = ""
    @body = {}
    render_to_json
  end
  
  def delete
    msg = current_user.message.find_by_id(:id=> params[:id])
    if msg.presence
      msg.delete
      @code = "ok"
    else
      @code = "error"
      @msg = "message doesn't exsit"      
    end
    
    render_to_json
  end
  
  def get_opponents
    opponent_ids = current_user.message.group(:opponent_id)
    puts opponent_ids
  end
  
end
