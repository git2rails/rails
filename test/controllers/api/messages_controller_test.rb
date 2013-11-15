require 'test_helper'

class Api::MessagesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  test "create message" do
    @request.headers["x-auth-token"] = users(:user1).authentication_token
    post :create, message: {opponent_id: users(:user2).id, text: "test message"}, format: :json
    
    assert_response 200, response.body
    assert JSON.parse(response.body)["header"]["code"] == Api::ApiController::ResultCode::SUCCESS, response.body
  end
  
  test "destroy message" do
    @request.headers["x-auth-token"] = users(:user1).authentication_token
    post :destroy, message: {id: messages(:msg1)}, format: :json
    
    assert_response 200, response.body
    assert JSON.parse(response.body)["header"]["code"].to_i == Api::ApiController::ResultCode::SUCCESS, response.body
  end
  
  test "show message" do
    @request.headers["x-auth-token"] = users(:user1).authentication_token
    get :show, page: 1, size: 4, format: :json
    
    assert_response 200, response.body
    assert JSON.parse(response.body)["header"]["code"].to_i == Api::ApiController::ResultCode::SUCCESS, response.body
    assert users(:user1).messages.count == JSON.parse(response.body)["body"].count, response.body
  end
  
end
