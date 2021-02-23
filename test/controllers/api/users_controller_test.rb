require 'test_helper'

class Api::UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @params = {
      name: 'Marvin', email: 'checkMarv@example.com',
      phone: '4014014014', password: '1' * 10,
      password_confirmation: '1' * 10,
    }
  end

  test 'CreateUser should Return JSON User and proper status ' do
    post api_users_path, params: @params
    #TODO assert Json
    assert_response :ok
  end

  test 'Should create User ' do
    assert_difference 'User.count' do
      post api_users_path, params: {user =>  @params}
    end

  end

  test 'Invalid submission returns unprocessable entity' do
    @params = {}
    post api_users_path, params: @params
    assert_response :unprocessable_entity
  end

  test 'Invalid submission does not add User to database' do
    @params[:name] = @params[:password_confirmation] = nil
    assert_no_difference 'User.count' do
      post api_users_path, params: { user: {
        name: 'Marvin', email: 'checkMarv@example.com',
        phone: '4014014014', password: '2' * 10,
        password_confirmation: '1' * 10,
      } }
    end
  end


end
