require 'test_helper'

class Api::SessionsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.new(
      name: 'Corey', email: 'CoreyG123@example.com',
      phone: '5556661122', password: 'foobardo',
      password_confirmation: 'foobardo'
    )
  end

  test 'Valid Authentication updates token' do
    post api_login_path, params: { session: {
      phone: @user.phone,
      password: @user.password }
    }
    assert_not @user.remember_token, 'Nil Remember Token After Valid Auth '
  end

  test 'Correct Authentication Returns Valid Response' do
    post api_login_path, params: { session: {
      phone: @user.phone, password: @user.password }
    }
    assert_response 202, "Valid Auth didn't return successful Response"
  end

  test 'Invalid authentication correct Response' do
    post api_login_path, params: {session: {
      phone: @user.phone, password: @user.password
    }}
    assert_response 422, "Invalid Auth didn't return Correct Response"
  end


end
