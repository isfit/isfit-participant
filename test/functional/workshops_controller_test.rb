require 'test_helper'

class WorkshopsControllerTest < ActionController::TestCase
  setup do
    @workshop = workshops(:politics)
    sign_in users(:kenny)
  end

  test "should get index" do
    get :index
    assert_response 302
  end

  test "should get show" do
    get :show, :id => @workshop.to_param
    assert_response 302
  end

  test "should get edit" do
    get :edit, :id => @workshop.to_param
    assert_response 302 #=> :success
  end

  test "should get update" do
    get :update, :id => @workshop.to_param
    assert_response 302
  end

end
