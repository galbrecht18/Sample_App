require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.new(name: "George Test", email: "test@test.com")
  end
  test "should be valid" do
    assert @user.valid?
  end
  test "name should be present" do
    @user.name = ""
    assert_not @user.valid?
  end 
  test "email should be present" do
    @user.email = ""
    assert_not @user.valid?
  end
  #length assertions
  test "name should not be longer than 50 characters" do
    @user.name = "a"*51
    assert_not @user.valid?
  end
  test "email should not be longer than 255 characters" do
    @user.email = "a"*244+"@example.com"
    assert_not @user.valid?
  end
end
