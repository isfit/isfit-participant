require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @stan = users(:stan)
  end

  test 'user results correct name' do
    assert_equal 'Stan Marsh',      @stan.full_name,  "Stan March is named #{@stan.full_name}"
  end

  test 'is functionary true if functionary' do
    assert @stan.is_functionary?,   'Stan isn\'t a functionary'
  end
  
  test 'is participant true if participant' do
    assert !@stan.is_participant?, 'Stan is a participant'
  end

  test 'user has role' do
    assert @stan.has_role?(:functionary), 'Stan has not functionary role'
    assert @stan.has_role?(:admin),       'Stan has not admin role'
  end
end
