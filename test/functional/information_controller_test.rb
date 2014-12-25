require 'test_helper'

class InformationControllerTest < ActionController::TestCase
  def setup
    sign_in users(:stan)
  end

  test "should get index" do
    get :index
    assert_response :success
  end
end
