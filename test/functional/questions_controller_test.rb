require 'test_helper'

class QuestionsControllerTest < ActionController::TestCase
  def setup
    @question = questions(:one)
    sign_in users(:randy)
  end

  test "should get index" do
    get :index
    assert_response 200
  end

  test "should get new" do
    get :new
    assert_response 200
  end

  test "should show question" do
    get :show, :id => @question.to_param
    assert_response 200
  end

  test "should get edit" do
    get :edit, :id => @question.to_param
    assert_response 200
  end
end
