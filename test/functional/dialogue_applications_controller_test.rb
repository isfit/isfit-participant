require 'test_helper'

class DialogueApplicationsControllerTest < ActionController::TestCase
  setup do
    @dialogue_application = dialogue_applications(:one)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dialogue_application" do
    assert_difference('DialogueApplication.count') do
      post :create, dialogue_application: { conflict_essay: @dialogue_application.conflict_essay, dialogue_essay: @dialogue_application.dialogue_essay, english_proficiency: @dialogue_application.english_proficiency, french_proficiency: @dialogue_application.french_proficiency, relationship_status: @dialogue_application.relationship_status, user_id: @dialogue_application.user_id, vision_essay: @dialogue_application.vision_essay }
    end

    assert_redirected_to dialogue_application_path(assigns(:dialogue_application))
  end

  test "should show dialogue_application" do
    get :show, id: @dialogue_application
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dialogue_application
    assert_response :success
  end

  test "should update dialogue_application" do
    put :update, id: @dialogue_application, dialogue_application: { conflict_essay: @dialogue_application.conflict_essay, dialogue_essay: @dialogue_application.dialogue_essay, english_proficiency: @dialogue_application.english_proficiency, french_proficiency: @dialogue_application.french_proficiency, relationship_status: @dialogue_application.relationship_status, user_id: @dialogue_application.user_id, vision_essay: @dialogue_application.vision_essay }
    assert_redirected_to dialogue_application_path(assigns(:dialogue_application))
  end

  test "should destroy dialogue_application" do
    assert_difference('DialogueApplication.count', -1) do
      delete :destroy, id: @dialogue_application
    end

    assert_redirected_to dialogue_applications_path
  end
end
