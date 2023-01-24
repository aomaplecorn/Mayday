require "test_helper"

class Artist::MusicsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get artist_musics_new_url
    assert_response :success
  end

  test "should get show" do
    get artist_musics_show_url
    assert_response :success
  end

  test "should get edit" do
    get artist_musics_edit_url
    assert_response :success
  end

  test "should get index" do
    get artist_musics_index_url
    assert_response :success
  end
end
