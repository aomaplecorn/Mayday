require "test_helper"

class Artist::ItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get artist_items_new_url
    assert_response :success
  end

  test "should get index" do
    get artist_items_index_url
    assert_response :success
  end

  test "should get show" do
    get artist_items_show_url
    assert_response :success
  end

  test "should get edit" do
    get artist_items_edit_url
    assert_response :success
  end
end
