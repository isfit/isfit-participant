require 'test_helper'

class ParticpantTest < ActiveSupport::TestCase
  def setup
    @eric = participants(:eric)
    @kenny = participants(:kenny)
  end

  test 'full name is correct' do
    assert_equal 'Eric Cartman',    @eric.full_name,  "Eric Cartman is named #{@eric.full_name}"
    assert_equal 'Kenny McCormick', @kenny.full_name, "Kenny McCormick is named #{@kenny.full_name}"
  end

  test 'workshop name is correct when workshop is set' do
    assert_equal 'Politics', @eric.workshop_name, 'Erics workshop is not politics'
  end

  test 'workshop name returns empty when no workshop is set' do
    assert_equal '', @kenny.workshop_name, 'Kenny is assigned to a workshop'
  end

  test 'has host returns true when host is given' do
    assert @eric.has_host?, 'Eric has not a host'
  end

  test 'has host returns false when no host is given' do
    assert !@kenny.has_host?, 'Kenny has a host'
  end
end
