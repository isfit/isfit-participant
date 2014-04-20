require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user1 = users(:one)
    @user2 = User.create!(email: "john.doe@example.com", password: "123456", first_name: 'John', last_name: 'Doe')

    @f = functionaries(:one)

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
    assert_equal "Kristian Vage", @user1.name
    assert_equal "John Doe", @user2.name
  end

  test "is functionary true if functionary" do
    assert @user1.is_functionary?
    assert !@user2.is_functionary?
  end
  
  test "is participant true if participant" do
    assert !@user1.is_participant?, 'User 1 is participant'
    assert @user2.is_participant?, 'User 2 is not participant'
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
