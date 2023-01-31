require "test_helper"

class Customer::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get customer_users_show_url
    assert_response :success
  end

  test "should get edit" do
    get customer_users_edit_url
    assert_response :success
  end
end
