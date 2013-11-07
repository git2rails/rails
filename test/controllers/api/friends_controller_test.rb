require 'test_helper'

class Api::FriendsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  test "should suggest friendship" do
    @request.headers["x-auth-token"] = "UXztQVWYKshfoT_x64F_"
    get :suggest, { :f=>[{ :friend_id=> 2}] }
    assert_response :success
    assert_equal 'ok', assigns(:code)
  end
end
