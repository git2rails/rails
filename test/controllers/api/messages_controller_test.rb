require 'test_helper'

class Api::MessagesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  test "should create message" do
    @request.headers["x-auth-token"] = "UXztQVWYKshfoT_x64F_"
    post :create, message: {opponent_id: 2, text: "test message"}, format: :json
    
    assert_response 200
    assert JSON.parse(response.body)["header"]["code"] == Api::ApiController::ResultCode::SUCCESS
    assert Message.find_by_opponent_id(2)
  end
  
  test "should destroy message" do
    @request.headers["x-auth-token"] = "UXztQVWYKshfoT_x64F_"
    post :create, message: {opponent_id: 2, text: "test message"}, format: :json
    post :destroy, message: {id: Message.all[0].id}, format: :json
    
    assert_response 200
    assert JSON.parse(response.body)["header"]["code"].to_i == Api::ApiController::ResultCode::SUCCESS
  end
end
