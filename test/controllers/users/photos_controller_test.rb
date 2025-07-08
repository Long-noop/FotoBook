require "test_helper"

class Users::PhotosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get users_photos_index_url
    assert_response :success
  end
end
