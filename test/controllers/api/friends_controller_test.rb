require 'test_helper'

class Api::FriendsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  test "should suggest friendship" do
    @request.headers["x-auth-token"] = "UXztQVWYKshfoT_x64F_"
    get :suggest, friendships: [{friend_id: 2}], format: :json
    assert_response :success
    assert JSON.parse(response.body)["header"]["code"].to_i == Api::ApiController::ResultCode::SUCCESS    
  end
  
  test "shoud accept friendship" do
    @request.headers["x-auth-token"] = "UXztQVWYKshfoT_x64F_"
    get :suggest, friendships: [{friend_id: 2}], format: :json

    ids = []    
    Friendship.all.each do |friendship|
      ids.push friendship.id
    end
    
    get :accept, ids: ids.join(","), format: :json
    
    puts Friendship.all.to_json
  end
  
end
