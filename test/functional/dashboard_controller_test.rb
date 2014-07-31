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

  test 'should return success when authenticated' do
    eric = FactoryGirl.create(:user)
    sign_in eric

    get :index
    assert_response :success
  end

  test 'should render applicant template when authenticated as applicant' do
    applicant_role = FactoryGirl.create(:role)
    eric = FactoryGirl.create(:user)
    eric.roles << applicant_role
    sign_in eric

    get :index
    assert_template 'index_applicant'
  end

  test 'should render admin template when authenticated as admin' do
    admin_role = FactoryGirl.create(:admin_role)
    eric = FactoryGirl.create(:user)
    eric.roles << admin_role
    sign_in eric

    get :index
    assert_template 'index_admin'
  end
end
