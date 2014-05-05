require 'test_helper'

class FinancialAidApplicationsControllerTest < ActionController::TestCase
  setup do
    @financial_aid_application = financial_aid_applications(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:financial_aid_applications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create financial_aid_application" do
    assert_difference('FinancialAidApplication.count') do
      post :create, financial_aid_application: { amount: @financial_aid_application.amount, can_come_anyway: @financial_aid_application.can_come_anyway, essay: @financial_aid_application.essay, other_sources: @financial_aid_application.other_sources, user_id: @financial_aid_application.user_id }
    end

    assert_redirected_to financial_aid_application_path(assigns(:financial_aid_application))
  end

  test "should show financial_aid_application" do
    get :show, id: @financial_aid_application
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @financial_aid_application
    assert_response :success
  end

  test "should update financial_aid_application" do
    put :update, id: @financial_aid_application, financial_aid_application: { amount: @financial_aid_application.amount, can_come_anyway: @financial_aid_application.can_come_anyway, essay: @financial_aid_application.essay, other_sources: @financial_aid_application.other_sources, user_id: @financial_aid_application.user_id }
    assert_redirected_to financial_aid_application_path(assigns(:financial_aid_application))
  end

  test "should destroy financial_aid_application" do
    assert_difference('FinancialAidApplication.count', -1) do
      delete :destroy, id: @financial_aid_application
    end

    assert_redirected_to financial_aid_applications_path
  end
end
