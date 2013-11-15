require 'test_helper'

class Api::ProfilesControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  test "update profile" do
    @request.headers["x-auth-token"] = users(:user1).authentication_token
    
    post :update, user: {
      sex: true,
      birthday: Date.new(2001,2,3),
      intro: "Hello!",
      city: "Seoul",
      sns: {kakao: "user1@kakao.com"}
    }, format: :json
    
    assert_response 200, response.body
    assert User.find_by_id(users(:user1).id).sns["kakao"] == "user1@kakao.com", response.body
  end

  test "update avatar" do
    @request.headers["x-auth-token"] = users(:user1).authentication_token
    
    image = fixture_file_upload "files/tom.jpg"
    post :update_avatar, file: image, format: :json
    
    puts response.body
    
    assert_response 200, response.body
  end
  
  test "update email and password" do
    @request.headers["x-auth-token"] = users(:user1).authentication_token
    
    post :update_email_password, user: { email: "user1@gmail.com", password: "user1_password"}, format: :json
    
    assert_response 200, response.body
  end
  
end
