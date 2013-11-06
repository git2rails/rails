class Api::FriendsController < Api::ApiController
 
  def suggest
    succeed_friend_ids = []
    failed_friend_ids = []
    
    params[:f].each do |f|
      
      if Friendship.find_by(:user_id=> current_user.id, :friend_id=> f[:friend_id]).presence
        failed_friend_ids.push f[:friend_id].to_i  
      end
      
      friendship = Friendship.new(:user_id=> current_user.id, :friend_id=> f[:friend_id], :status=> 1 )
      if friendship.save
        succeed_friend_ids.push f[:friend_id].to_i
      else
        failed_friend_ids.push f[:friend_id].to_i
      end
      
    end
    
    if succeed_friend_ids.count == params[:f].count
      render :json=> {
        :header=> 'ok',
        :desc=> '',
        :body=> {
          :succeed_friend_ids=> succeed_friend_ids
        }
      }
    else
      render :json=> {
        :header=> 'error',
        :desc=> '',
        :body=> {
          :failed_friend_ids=> failed_friend_ids
        }
      }
    end
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
      
      if friendship.update(:status => 2)
        succeed_friend_ids.push f[:friend_id].to_i
      else
        failed_friend_ids.push f[:friend_id].to_i
      end
    end
    

    if succeed_friend_ids.count == params[:f].count
      render :json=> {
        :header=> 'ok',
        :dsec=> '', 
        :body=> {}
      }
    else
      render :json=> {
        :header=> 'error',
        :desc=> '',
        :body=> {
          :failed_friend_ids=> failed_friend_ids
        }
      }
    end
    
  end
  
  def block
    puts current_user.friends.find_by(:friend_id=> params[:friend_id])
  end
  
  def get
    friends = current_user.friends
    friends.concat(current_user.inverse_friends)
    
    render :json=> {
      :header=> 'ok',
      :desc=> '',
      :body=> {
        :friends=> friends 
      }
    }
  end  

end
