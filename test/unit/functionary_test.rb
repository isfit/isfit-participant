require 'test_helper'

class FunctionaryTest < ActiveSupport::TestCase
  def setup
    @stan = functionaries(:stan)
    @kyle = functionaries(:kyle)

  end

  test 'has full name' do
    assert_equal 'Stan Marsh',      @stan.full_name,  "Stan March is named #{@stan.full_name}"
    assert_equal 'Kyle Broflovski', @kyle.full_name,  "Kyle Broflovski is named #{@kyle.full_name}"
  end
end
