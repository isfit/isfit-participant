require 'test_helper'

class FunctionaryTest < ActiveSupport::TestCase
  def setup
    @f = functionaries(:one)
  end

  test "has full name" do
    assert_equal 'Kristian Vage', @f.full_name
  end
end
