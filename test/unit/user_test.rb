require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @stan = users(:stan)
    @kyle = users(:kyle)
    @eric = users(:eric)
    @kenny = users(:kenny)
  end

  test 'user results correct name' do
    assert_equal 'Stan Marsh',      @stan.name,  "Stan March is named #{@stan.name}"
    assert_equal 'Kyle Broflovski', @kyle.name,  "Kyle Broflovski is named #{@kyle.name}"
    assert_equal 'Eric Cartman',    @eric.name,  "Eric Cartman is named #{@eric.name}"
    assert_equal 'Kenny McCormick', @kenny.name, "Kenny McCormick is named #{@kenny.name}"
  end

  test 'is functionary true if functionary' do
    assert @stan.is_functionary?,   'Stan isn\'t a functionary'
    assert @kyle.is_functionary?,   'Kyle isn\'t a functionary'
    assert !@eric.is_functionary?,  'Eric is a functionary'
    assert !@kenny.is_functionary?, 'Kenny is a functionary'
  end
  
  test 'is participant true if participant' do
    assert !@stan.is_participant?, 'Stan is a participant'
    assert !@kyle.is_participant?, 'Kyle is a participant'
    assert @eric.is_participant?,  'Eric isn\'t a participant'
    assert @kenny.is_participant?, 'Kenny isn\'t a participant'
  end

  test 'user has role' do
    assert @stan.has_role?(:functionary), 'Stan has not functionary role'
    assert @stan.has_role?(:admin),       'Stan has not admin role'

    assert @kyle.has_role?(:functionary), 'Kyle has not functionary role'
    assert @kyle.has_role?(:theme),       'Kyle has not theme role'

    assert @eric.has_role?(:participant),  'Eric has not participant role'

    assert @kenny.has_role?(:participant), 'Kenny has not participant role'
  end
end
