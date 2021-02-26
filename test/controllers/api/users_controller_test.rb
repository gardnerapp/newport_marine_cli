require 'test_helper'

class Api::UsersControllerTest < ActionDispatch::IntegrationTest

  include APIUserController

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
    create_user(@user)
    user = User.last
    assert_not user.remember_token
  end

  test 'Token decrypts to Digest in DB' do
    create_user(@user)
    token = json_parse(@response.body)['token']
    user = User.last
    assert user.authenticated? token
  end


  test 'Correct JSON & Status 202 :accepted Returned From User Creation' do
    create_user(@user)
    response = json_parse(@response.body)
    assert_equal @user[:name], response['name']
    assert_equal @user[:email], response['email']
    assert_equal @user[:phone], response['phone']
    assert_response 202
  end

  test 'Create should Change DB' do
    assert_difference 'User.count' do
      create_user(@user)
    end
  end

  test 'Invalid submission returns 422 :unprocessable_entity' do
    @user['password'] = nil
    create_user(@user)
    assert_response :unprocessable_entity
  end

end
