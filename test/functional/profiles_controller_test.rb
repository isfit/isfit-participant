require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase
  setup do
    @profile = profiles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:profiles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create profile" do
    assert_difference('Profile.count') do
      post :create, profile: { address: @profile.address, calling_code: @profile.calling_code, citizenship: @profile.citizenship, city: @profile.city, country: @profile.country, date_of_birth: @profile.date_of_birth, field_of_study: @profile.field_of_study, gender: @profile.gender, gender_specify: @profile.gender_specify, nationality: @profile.nationality, phone: @profile.phone, postal_code: @profile.postal_code, school: @profile.school }
    end

    assert_redirected_to profile_path(assigns(:profile))
  end

  test "should show profile" do
    get :show, id: @profile
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @profile
    assert_response :success
  end

  test "should update profile" do
    put :update, id: @profile, profile: { address: @profile.address, calling_code: @profile.calling_code, citizenship: @profile.citizenship, city: @profile.city, country: @profile.country, date_of_birth: @profile.date_of_birth, field_of_study: @profile.field_of_study, gender: @profile.gender, gender_specify: @profile.gender_specify, nationality: @profile.nationality, phone: @profile.phone, postal_code: @profile.postal_code, school: @profile.school }
    assert_redirected_to profile_path(assigns(:profile))
  end

  test "should destroy profile" do
    assert_difference('Profile.count', -1) do
      delete :destroy, id: @profile
    end

    assert_redirected_to profiles_path
  end
end
