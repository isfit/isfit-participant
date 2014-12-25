require 'test_helper'

class Faq::CategoriesControllerTest < ActionController::TestCase
  def setup
    sign_in users(:randy)
  end

  test "should get index" do
    get :index
    assert_response :success
  end
end
