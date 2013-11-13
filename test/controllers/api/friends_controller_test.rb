require 'test_helper'

class Api::FriendsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  test "shoud suggest and accept friendship" do
    user1 = User.find_by name: 'user1'
    user2 = User.find_by name: 'user2'
    user3 = User.find_by name: 'user3'
    
    @request.headers["x-auth-token"] = user1.authentication_token
    get :suggest, friendships: [{friend_id: user2.id}, {friend_id: user3.id}], format: :json
    
    assert_response 200
    assert JSON.parse(response.body)["header"]["code"].to_i == Api::ApiController::ResultCode::SUCCESS
    
    sign_out user1
    
    ids = []
    Friendship.find_by friend_id: user2.id do |friendship|
      ids.push friendship.id
    end
    
    @request.headers["x-auth-token"] = user2.authentication_token
    get :accept, ids: ids.join(","), format: :json
    
    assert_response 200
    assert JSON.parse(response.body)["header"]["code"].to_i == Api::ApiController::ResultCode::SUCCESS
    
    friendship = user2.inverse_friendships.find_by_user_id(user1.id)
    assert friendship.friend_status = 2
  end
  
end
