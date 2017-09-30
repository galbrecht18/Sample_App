require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "login with invalid information" do
    get login_path # go to the login page
    assert_template 'sessions/new' # assert that we are seeing the new / login page
    post login_path, params: { session: {email: "", password: ""}} # submit from the login page
    assert_template 'sessions/new' # assert that we are seeing the login page again since our request was invalid
    assert_not flash.empty? # assert we have a flash message
    get root_path # visit the home page
    assert flash.empty? # assert that we aren't seeing the flash message
  end
end
