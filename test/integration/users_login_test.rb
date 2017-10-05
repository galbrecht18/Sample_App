require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:michael)
  end
  test "login with invalid information" do
    get login_path # go to the login page
    assert_template 'sessions/new' # assert that we are seeing the new / login page
    post login_path, params: { session: {email: "", password: ""}} # submit from the login page
    assert_template 'sessions/new' # assert that we are seeing the login page again since our request was invalid
    assert_not flash.empty? # assert we have a flash message
    get root_path # visit the home page
    assert flash.empty? # assert that we aren't seeing the flash message
  end
  test "login with valid information" do
    get login_path
    post login_path, params: { session: {email: @user.email, password: 'password'}}
    assert_redirected_to @user
    follow_redirect!
    assert_select "a[href=?]", login_path, count: 0 # there are no login links on the page
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
  end

  test "login with valid information followed by logout" do
    get login_path
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end
end
