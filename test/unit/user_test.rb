require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @stan = users(:stan)
  end

  test 'user results correct name' do
    assert_equal 'Stan Marsh',      @stan.full_name,  "Stan March is named #{@stan.full_name}"
  end
end
