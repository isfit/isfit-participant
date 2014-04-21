require 'test_helper'

class HostTest < ActiveSupport::TestCase
  def setup
    @randy = hosts(:randy)
  end

  test 'has full name' do
    assert_equal 'Randy March', @randy.full_name
  end
end
