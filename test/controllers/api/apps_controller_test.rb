require 'test_helper'

class Api::AppsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  

  test "index app" do
    @request.headers["x-auth-token"] = "UXztQVWYKshfoT_x64F_"
    get :index, apps: {page: 1, er_page: 5}, format: :json
    assert_response 200
    puts JSON.parse(response.body)["body"].size
    assert JSON.parse(response.body)["body"].size == 11572
    assert JSON.parse(response.body)["body"] == App.all.to_json
  end
end
