require 'test_helper'

class Api::MessagesControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "should send message" do
    @request.headers["x-auth-token"] = "UXztQVWYKshfoT_x64F_"
    post :send, {:recipient_id=> 2, :text=> "test message"}
    
    puts assigns(:code)
    puts assigns(:msg)
  end
end
