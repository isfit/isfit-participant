require 'test_helper'

class FunctionaryTest < ActiveSupport::TestCase
  def setup
    @f = Functionary.new
    @f.first_name = "Placeholder"
    @f.last_name = "Placeholdersen"
  end


  test "has full name" do
    assert_equal "Placeholder Placeholdersen", @f.full_name
  end
end
