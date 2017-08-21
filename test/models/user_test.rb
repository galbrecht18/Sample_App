require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.new(name: "George Test", email: "test@test.com",
                      password: "foobar", password_confirmation: "foobar")
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
  #valid email address tests
  test "email should accept valid email addresses" do
    valid_addresses = %w[test@test.com USER@foo.COM]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  test "invalid email addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  #unique emails
  test "email addresses should be unique" do
    dupe_user = @user.dup
    dupe_user.email = @user.email.upcase
    @user.save
    assert_not dupe_user.valid?
  end
  #password tests
  test "password musn't be blank" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end
  test "password must have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
end
