require "test_helper"

class Artist::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get artist_users_show_url
    assert_response :success
  end

  test "should get edit" do
    get artist_users_edit_url
    assert_response :success
  end
end
