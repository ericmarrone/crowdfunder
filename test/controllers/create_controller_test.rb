require 'test_helper'

class CreateControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get create_update_url
    assert_response :success
  end

end
