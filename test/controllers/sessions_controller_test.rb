require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  #TODO Move Sessions and USer Test Over to API
  def setup
    @user = users(:corey)
  end

  test 'Only phone and password params allowed' do
    post api_login_path, params: {
      phone: @user.phone, #is this the proper way to reference fixture data
      password: @user.password,
      hog: "Yo I'm trying to hack your application by sending remote curl request"
    }
    assert_response :unprocessable_entity

  end

  test 'Valid submission returns user' do
    post api_login_path, params: {
      phone: @user.phone, #is this the proper way to reference fixture data
      password: @user.password
    }
    assert_response :accepted
    #TODO return user in JSon
  end

  test 'Blank submission returns unprocessable' do
    post api_login_path, params: {}
    assert_response :unprocessable_entity
  end

  test 'Wrong authentication returns unprocessable' do
    post api_login_path, params: {
      phone: @user.phone, #is this the proper way to reference fixture data
      password: @user.email
    }
    assert_response :unprocessable_entity
  end

end
