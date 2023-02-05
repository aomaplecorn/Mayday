require "test_helper"

class Customer::AlbumsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get customer_albums_index_url
    assert_response :success
  end

  test "should get show" do
    get customer_albums_show_url
    assert_response :success
  end
end
