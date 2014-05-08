require 'test_helper'

class LandingControllerTest < ActionController::TestCase
  test 'should get index when logged out' do
    get :index
    assert_response :success
  end

  test 'should get redirect when logged in' do
    sign_in users(:kyle)

    get :index
    assert_redirected_to dashboard_url
  end
end
