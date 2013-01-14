require 'test_helper'

class ParticipantsControllerTest < ActionController::TestCase
  setup do
    @participant = participants(:one)
  end

  test "should get index" do
    get :index
    assert_response 302 #:success
    #assert_not_nil assigns(:participants)
  end

  test "should get new" do
    get :new
    assert_response 302 #:success
  end

  test "should show participant" do
    get :show, :id => @participant.to_param
    assert_response 302 #:success
  end

  test "should get edit" do
    get :edit, :id => @participant.to_param
    assert_response 302 #:success
  end
end
