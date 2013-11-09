require 'test_helper'

class Api::AppsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  

  test "index app" do
    @request.headers["x-auth-token"] = "UXztQVWYKshfoT_x64F_"
    get :index, apps: {}, format: :json
    assert_response 200
    puts JSON.parse(response.body)["header"]
    assert JSON.parse(response.body)["body"] == App.all.to_json
    assert JSON.parse(response.body).size ==2
  end
end
