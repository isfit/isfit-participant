require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase
  setup do
    @user = users(:kyle)
    @user.profile.destroy

    sign_in @user
  end

  test "should get new" do
    get :new, user_id: @user.id
    assert_response :success
  end

  test "should create profile" do
    usa = countries(:usa)
    assert_difference('Profile.count') do
      post :create, profile: { address: 'E. Bonanza St.', postal_code: 80440, city: 'South Park', nationality: 'American', citizenship_id: usa.id, country_id: usa.id, calling_code: 1, phone: 80000100, date_of_birth: '1996-04-24', gender: 1, school: 'South Park Elementary', field_of_study: 'Primary', motivation_essay: '' }, user_id: @user.id
    end

    assert_redirected_to dashboard_url
  end
end
