require 'test_helper'

class HostTest < ActiveSupport::TestCase
  def setup
    @host = Host.new
    @host.first_name = "First"
    @host.last_name = "Last"
  end


  test "has full name" do
    assert_equal "First Last", @host.full_name
  end
end
