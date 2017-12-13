require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    skip
    get comments_create_url
    assert_response :success
  end

  test "should get update" do
    skip
    get comments_update_url
    assert_response :success
  end

  test "should get destroy" do
    skip
    get comments_destroy_url
    assert_response :success
  end

end
