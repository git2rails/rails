require 'test_helper'

class Api::PostsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  test "create post" do
    @request.headers["x-auth-token"] = "UXztQVWYKshfoT_x64F_"
    post :create, post: {content: "test"}, format: :json
    assert_response :success
  end
end
