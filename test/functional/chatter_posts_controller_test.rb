require 'test_helper'

class ChatterPostsControllerTest < ActionController::TestCase
  test "should get comment" do
    get :comment
    assert_response :success
  end

  test "should get like" do
    get :like
    assert_response :success
  end

end
