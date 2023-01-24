require "test_helper"

class Artist::AlbumsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get artist_albums_new_url
    assert_response :success
  end

  test "should get index" do
    get artist_albums_index_url
    assert_response :success
  end

  test "should get show" do
    get artist_albums_show_url
    assert_response :success
  end

  test "should get edit" do
    get artist_albums_edit_url
    assert_response :success
  end
end
