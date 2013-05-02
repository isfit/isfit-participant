require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user1 = User.create!(email: "jane.doe@example.com", password: "123456")
    @user2 = User.create!(email: "john.doe@example.com", password: "123456")
    @f = Functionary.new
    @f.first_name = "Jane"
    @f.last_name = "Doe"
    @f.user_id = @user1.id
    @f.save
    @p = Participant.new
    @p.first_name = "John"
    @p.last_name = "Doe"
    @p.user_id = @user2.id
    @p.save
    
    @admin = Role.create!(name: "admin")
    @functionary = Role.create!(name: "functionary")
    @participant = Role.create!(name: "participant")
    @user1.roles << @admin
    @user1.roles << @functionary
    @user2.roles << @participant
  end

  test "user results correct name" do
    assert_equal "Jane Doe", @user1.name
    assert_equal "John Doe", @user2.name
  end

  test "is functionary true if functionary" do
    assert @user1.is_functionary?
    assert !@user2.is_functionary?
  end
  
  test "is participant true if participant" do
    assert !@user1.is_participant?
    assert @user2.is_participant?
  end

  test "user has role" do
    assert @user1.has_role?(:admin)
    assert @user1.has_role?(:functionary)
    assert !@user1.has_role?(:participant)
    assert !@user2.has_role?(:admin)
    assert !@user2.has_role?(:functionary)
    assert @user2.has_role?(:participant)
  end
end
