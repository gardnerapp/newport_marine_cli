require 'test_helper'

class Api::SessionsControllerTest < ActionDispatch::IntegrationTest

  include APISessionsController

  # TODO Make Boat For Fixture, assert that proper data
  # and boat are present in response

  def setup
    @user = users(:corey)
  end

  test 'Valid Authentication Updates Token & Token Decrypts to digest' do
    login_user(@user, 'password')
    token = json_parse(@response.body)['token']
    assert_not token.nil?, 'Token is not present'
    user = User.find_by(phone: @user.phone)
    assert user.authenticated?(token), "Token doesn't match digest"
  end

  test 'Correct Authentication Returns Valid Response' do
    login_user(@user, 'password')
    assert_response :success, 'Bad status upon valid authentication'
  end
  
  test 'Invalid authentication returns status 422 :unprocessable entity' do
     login_user(@user, 'incorrect password')
     assert_response 422
  end

end
