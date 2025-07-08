require "test_helper"

class Users::AlbumsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get users_albums_show_url
    assert_response :success
  end

  test "should get edit" do
    get users_albums_edit_url
    assert_response :success
  end

  test "should get update" do
    get users_albums_update_url
    assert_response :success
  end
end
