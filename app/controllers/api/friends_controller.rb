class Api::FriendsController < Api::ApiController
 
  def suggest
    friendships = friendship_params[:friendships]
    
    succeed_friend_ids = []
    failed_friend_ids = []

    friendships.each do |friendship|
      friendship[:user_id] = current_user.id
      
      if Friendship.find_by(friendship).presence
        failed_friend_ids.push friendship[:friend_id].to_i  
      end
      
      new_friendship = Friendship.new(friendship)
      new_friendship.user_status = 2
      new_friendship.friend_status = 1
      
      if new_friendship.save
        succeed_friend_ids.push friendship[:friend_id].to_i
      else
        puts new_friendship.to_json
        puts new_friendship.errors.to_json
        failed_friend_ids.push friendship[:friend_id].to_i
      end
    end
    
    if succeed_friend_ids.count == friendships.count
      respond_to do |format|
        format.json { render json: to_json(ResultCode::SUCCESS, '', succeed_friend_ids), status: 200 }
        
      end
    else
      respond_to do |format|
        format.json { render json: to_json(ResultCode::ERROR, '', failed_friend_ids), status: 200}
      end
    end
  end
  
  def accept
    ids = params[:ids].split(",")
    
    succeed_ids = []
    failed_ids = []
    
    ids.each do |id|
      friendship = Friendship.find_by id: id, friend_id: current_user.id
      
      unless friendship.presence
        failed_ids.push id
        next
      end
      
      if friendship.update(friend_status: 2)
        succeed_ids.push id
      else
        failed_ids.push id
      end
    end


    if succeed_ids.count == ids.count
      respond_to do |format|
        format.json { render json: to_json(ResultCode::SUCCESS, '', {}), status: 200}
      end
    else
      respond_to do |format|
        format.json { render json: to_json(ResultCode::ERROR, '', failed_ids), status: 200}
      end      
    end
  end
  
  def block
    friendship = current_user.friendships.find_by_id(params[:id])
    
    if friendship.presence
      friendship.user_status = 3
      friendship.save
      
      respond_to do |format|
        format.json { render json: to_json(ResultCode::SUCCESS, '', {}), status: 200}
      end
      
      return
    end
    
    inverse_friendship = current_user.inverse_friendships.find_by_id(params[:id])
    
    if inverse_friendship.presence
      inverse_friendship.friend_status = 3
      inverse_friendship.save

      respond_to do |format|
        format.json { render json: to_json(ResultCode::SUCCESS, '', {}), status: 200}
      end      
    else
      respond_to do |format|
        format.json { render json: to_json(ResultCode::ERROR, '', {}), status: 200}
      end            
    end
  end
  
  def show
    friends = current_user.friends
    friends.concat(current_user.inverse_friends)
 
    respond_to do |format|
      format.json { render json: to_json(ResultCode::SUCCESS, '', friends), status: 200}
    end             
  end
  
  private
    def friendship_params
      params.permit(friendships: [:user_id, :friend_id, :user_status, :friend_status])
    end
end
