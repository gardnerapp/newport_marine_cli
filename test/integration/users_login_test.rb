require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  
  def setup 
    @user = users :corey
  end
  # Config so that it only works w admins
  test 'Login with invalid information' do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: {session: {email: '', password: ''}}
    assert_not is_logged_in?
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
  
  test 'Login with valid information followed by logout' do
    get login_path 
    assert_template 'sessions/new'
    post login_path, params: {session: {email: @user.email, password: 'password'}}
    assert is_logged_in?
    assert_redirected_to root_url
    follow_redirect! 
    assert_template 'layouts/home'
    assert_select 'a[href=?]', login_path, count: 0 
    assert_select 'a[href=?]', logout_path
    # TODO assert_seleclt other nav item links when logged in
    # make fixture an admin
    delete login_path
    assert_redirected_to login_path
    follow_redirect!
    # TODO assert_seleclt other nav item links when logged in
  end

  test 'login with valid email, invalid password' do 
    get login_path
    assert_template 'sessions/new'
    post login_path params: {session: {email: @user.email, password: 'False password'}}
    assert_not is_logged_in?
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
    # TODO assert that the navbar links are correct IN all of the test
  end
  
  test 'login with valid info but user != admin' do

  end
end
