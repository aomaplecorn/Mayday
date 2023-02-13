require "test_helper"

class Artist::OrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get artist_orders_index_url
    assert_response :success
  end

  test "should get show" do
    get artist_orders_show_url
    assert_response :success
  end
end
