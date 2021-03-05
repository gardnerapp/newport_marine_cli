require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
    @user = users(:corey)
  end

  test 'password resets ' do
    post password_reset_path, params: { password_reset: {email: ''} }
    assert_response 422

    # Valid email 
    post password_reset_path, params: { password_reset: {email: @user.email }}
    assert_not_equal @user.reset_digest, @user.reload.reset_digest 
    assert_equal 1, ActionMailer::Base.deliveries.size 
    # User then goes to their email & Clicks the link 
    # & Travels to the Password Reset Form
    user = assigns(:user)

    # Wrong email 
    get edit_password_reset_path(user.reset_token, email: '')
    assert_redirected_to 'password_resets/error'

    # Right email wrong token 
    get edit_password_reset_path('Nota valid token by any means dawg', email: user.email)
    assert_not flash.empty? # TODO make the redirect go to something else
    assert_redirected_to 'password_resets/success'

    # right email right token
    get edit_password_reset_path(@user.reset_token, email: @user.email)
    assert_template 'password_resets/edit'
    assert_select 'input[name=email][type=hidden][value=?]', user.email
    assert_not flash.empty? # TODO make the redirect go to something else
    assert_redirected_to 'password_resets/success'

    # invalid password & confirmation
    patch password_reset_path(user.reset_token), params: {
      email: user.email, 
      user: {
        password: 'Foobaz',
        password_confirmation: 'Not foobase'
      }
    }
    assert_template 'password_resets/edit'

    # empty password 
    patch password_reset_path(user.reset_token), params: {
      email: user.email,
      user: {
        password: '',
        password_confirmation: ''
      }
    }
    assert_template 'password_resets/edit'
    # todo assert error explanation

    # valid password and confirmation
    patch password_reset_path(user.reset_token), params: {
      email: user.email,
      user: {
        password: 'foobaz',
        password_confirmation: 'foobaz'
      }
    }
    assert_redirected_to success_path
  end
end
