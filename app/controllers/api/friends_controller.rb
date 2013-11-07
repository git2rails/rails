class Api::FriendsController < Api::ApiController
 
  def suggest
    succeed_friend_ids = []
    failed_friend_ids = []
    
    params[:f].each do |f|
      
      if Friendship.find_by(:user_id=> current_user.id, :friend_id=> f[:friend_id]).presence
        failed_friend_ids.push f[:friend_id].to_i  
      end
      
      friendship = Friendship.new(:user_id=> current_user.id, :friend_id=> f[:friend_id], :user_status=> 2, :friend_status=> 1 )
      if friendship.save
        succeed_friend_ids.push f[:friend_id].to_i
      else
        failed_friend_ids.push f[:friend_id].to_i
      end
      
    end
    
    if succeed_friend_ids.count == params[:f].count
      @code = "ok"
      @msg = ""
      @body = {}
    else
      @code = "error"
      @msg = ""
      @body = {
        :failed_friend_ids=> failed_friend_ids
      }
    end
    
    render_to_json
  end
  
  def accept
    
    succeed_friend_ids = []
    failed_friend_ids = []
    
    params[:f].each do |f|
      friendship = Friendship.find_by(:user_id=> current_user.id, :friend_id=> f[:friend_id])
       
      unless friendship.presence
        failed_friend_ids.push f[:friend_id].to_i
        next
      end
      
      if friendship.update(:friend_status => 2)
        succeed_friend_ids.push f[:friend_id].to_i
      else
        failed_friend_ids.push f[:friend_id].to_i
      end
    end
    

    if succeed_friend_ids.count == params[:f].count
      @code = "ok"
      @msg = ""
      @body = {}
    else
      @code = "error"
      @msg = ""
      @body = {
        :failed_friend_ids=> failed_friend_ids
      }
    end
    render_to_json
  end
  
  def block
    friendship = current_user.friendships.find_by(:friend_id=> params[:friend_id]).first
    
    if friendship.presence
      friendship.user_status = 3
      friendship.save
      
      @code = "ok"
      @msg = ""
      @body = {}
      
      render_to_json
      return
    end
    
    inverse_friendship = current_user.inverse_friendships.find_by(:user_id=> params[:friend_id]).first
    
    if inverse_friendship.presence
      inverse_friendship.friend_status = 3
      inverse_friendship.save
      
      @code = "ok"
      @msg = ""
      @body = {}
      
      render_to_json
    else
      @code = "error"
      @msg = ""
      @body = {}      
    end
  end
  
  def get
    friends = current_user.friends
    friends.concat(current_user.inverse_friends)
 
    @code = "ok"
    @msg = ""
    @body = {
      :friends=> friends
    }
    render_to_json
  end  

end
