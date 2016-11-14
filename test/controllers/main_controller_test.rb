require 'test_helper'

class MainControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get dog" do
    get :dog
    assert_response :success
  end

  test "should get people" do
    get :people
    assert_response :success
  end

end
