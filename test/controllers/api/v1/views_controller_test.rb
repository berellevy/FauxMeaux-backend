require 'test_helper'

class Api::V1::ViewsControllerTest < ActionDispatch::IntegrationTest
  test "should get unlock" do
    get api_v1_views_unlock_url
    assert_response :success
  end

end
