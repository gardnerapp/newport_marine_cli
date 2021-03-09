require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  
  def setup 
    @user = users :corey
    @non_admin = users :reggie
  end

  test 'Root redirects to home for non logged in user' do
    get root_path
    assert_redirected_to login_path
  end

  test 'Login with invalid information' do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: '', password: '' } }
    assert_not is_logged_in?
    assert_template 'sessions/new'
  end

  test 'Login with valid information followed by logout' do
    get login_path 
    assert_template 'sessions/new'
    post login_path, params: { session: { email: @user.email, password: 'password' } }
    assert is_logged_in?
    assert_redirected_to root_url
    follow_redirect! 
    assert_template 'layouts/home'
    assert_select 'a[href=?]', login_path, count: 0 
    assert_select 'a[href=?]', logout_path
    assert_select 'a[href=?]', revenue_path
    assert_select 'a[href=?]', unpaid_path
    assert_select 'a[href=?]', root_path
    delete login_path
    assert_redirected_to login_path
    follow_redirect!
    assert_select 'a[href=?]', login_path
    assert_select 'a[href=?]', logout_path, count: 0
    assert_select 'a[href=?]', revenue_path, count: 0
    assert_select 'a[href=?]', unpaid_path, count: 0
    assert_select 'a[href=?]', root_path
  end

  test 'login with valid email, invalid password' do 
    get login_path
    assert_template 'sessions/new'
    post login_path params: { session: { email: @user.email, password: 'False password' } }
    assert_not is_logged_in?
    assert_template 'sessions/new'
  end

  # Todo create appointment fixtures, then move to asserting that user is admin in controller
  test 'Failed login if user is not admin' do
    get login_path
    assert_template 'sessions/new'
    post login_path params: { session: { email: @non_admin.email, password: 'password' } }
    assert_not is_logged_in?
    follow_redirect! # redirects w 302 to root then to login 
    assert_redirected_to login_path
  end

  # todo make bug section & notes

end
