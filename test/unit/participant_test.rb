require 'test_helper'

class ParticpantTest < ActiveSupport::TestCase
  def setup
    @p = Participant.new
    @p.first_name = "Test"
    @p.last_name = "Testsen"

    @w = Workshop.new
    @w.id = 1
    @w.name = "Photo"
    @w.save

    @h = Host.create!()

    @p.workshop_id = @w.id
    @p.host_id = @h.id
  end


  test "full name is correct" do
    assert_equal "Test Testsen", @p.full_name
  end

  test "workshop name is correct when workshop is set" do
    assert_equal "Photo", @p.workshop_name
  end

  test "workshop name returns empty when no workshop is set" do
    @p.workshop_id = nil
    assert_equal "", @p.workshop_name
  end

  test "has host returns true when host is given" do
    assert @p.has_host?
  end

  test "has host returns false when no host is given" do
    @p.host_id = nil
    assert (not @p.has_host?)
  end

  test "sortable fields is defined as array" do
    assert Participant.sortable_fields.class == Array
  end

end
