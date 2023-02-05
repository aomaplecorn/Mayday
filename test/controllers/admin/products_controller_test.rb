require "test_helper"

class Admin::ProductsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_products_index_url
    assert_response :success
  end

  test "should get item_show" do
    get admin_products_item_show_url
    assert_response :success
  end

  test "should get album_show" do
    get admin_products_album_show_url
    assert_response :success
  end
end
