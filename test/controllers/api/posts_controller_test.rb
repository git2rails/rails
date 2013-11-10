require 'test_helper'

class Api::PostsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  test "create post" do
    @request.headers["x-auth-token"] = "11UXztQVWYKshfoT_x64F_"
    post :create, post: {content: "test"}, format: :json
    assert_response 401
  end

  test "index post" do
    @request.headers["x-auth-token"] = "UXztQVWYKshfoT_x64F_"
    get :index, {app_id: 1, format: :json}
    assert_response 200
    puts JSON.parse(response.body)["body"]
    #assert JSON.parse(response.body)["body"]["posts"].size ==2
  end
end
