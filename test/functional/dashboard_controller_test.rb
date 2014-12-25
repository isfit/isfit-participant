require 'test_helper'

class DashboardControllerTest < ActionController::TestCase
  test 'should get redirect when not authenticated' do
    get :index
    assert_response :redirect
  end

  test 'should get redirected to login when not authenticated' do
    get :index
    assert_redirected_to new_user_session_url
  end
end
