require 'test_helper'

class UserRoomsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_rooms_index_url
    assert_response :success
  end

end
