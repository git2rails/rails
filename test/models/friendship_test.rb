require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase
  
  test "should not save without user_status" do
    friendship = Friendship.new(
      :user_id=> 1,
      :friend_id=> 2,
      :friend_status=> 1 
    )
    
    assert !friendship.save, "saved the friendship without user_status"
  end
  
end
