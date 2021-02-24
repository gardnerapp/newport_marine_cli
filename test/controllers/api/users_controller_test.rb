require 'test_helper'

class Api::UsersControllerTest < ActionDispatch::IntegrationTest

  # TODO Figure Out How to Work W JSON

  def setup
    @user = {
      name: 'corey', 
      email: '123youareahog@example.com',
      phone: '9098088877', 
      password: 'foobar', 
      password_confirmation: 'foobar'
    }
  end
  
  test 'Token Created Upon User Creation' do 
    post api_users_path, params: {
      user: @user 
    }
    user = User.last
    assert_not user.remember_token
  end

  test 'Correct JSON & Status Returned From User Creation' do
    post api_users_path, params: { 
      user: @user 
    }
    assert_response 202
  end

  test 'Create should Change DB' do
    assert_difference 'User.count' do
      post api_users_path, params: { user: @user }
    end

  end

  test 'Invalid submission returns unprocessable entity' do
    @user['password'] = nil
    post api_users_path, params: { user: @user

    }
    assert_response :unprocessable_entity
  end
  
end
