require 'test_helper'

class Api::FriendsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  test "shoud suggest friendship" do
    @request.headers["x-auth-token"] = users(:user1).authentication_token
    post :suggest, friendships: [{friend_id: users(:user3).id}], format: :json
    
    assert_response 200
    assert JSON.parse(response.body)["header"]["code"].to_i == Api::ApiController::ResultCode::SUCCESS, response.body.to_json
  end    
    
  test "shoud accept friendship" do    
    @request.headers["x-auth-token"] = users(:user2).authentication_token
    post :accept, ids: [friendships(:user1_to_user2).id].join(","), format: :json
    
    assert_response 200
    assert JSON.parse(response.body)["header"]["code"].to_i == Api::ApiController::ResultCode::SUCCESS, response.body.to_json
    
    #friendship = users(:user2).inverse_friendships.find_by_user_id(users(:user1).id)
    #assert friendship.friend_status = 2
  end
  
  test "should block friendship" do    
    @request.headers["x-auth-token"] = users(:user1).authentication_token
    post :block, id: friendships(:user1_to_user2).id, format: :json
    
    assert_response 200
    assert JSON.parse(response.body)["header"]["code"].to_i == Api::ApiController::ResultCode::SUCCESS, response.body.to_json
  end
  
  test "should show friendship" do
    @request.headers["x-auth-token"] = users(:user1).authentication_token
    get :show, format: :json
    
    assert_response 200
    body = JSON.parse(response.body)
    assert body.count == 2
  end
  
end
