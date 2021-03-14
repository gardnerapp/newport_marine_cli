require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test 'password reset' do 
    user = users(:corey)
    user.reset_token = User.new_token
    mail = UserMailer.passwords_reset user
    assert_equal 'Newport Marine Detailing Password Reset', mail.subject
    assert_equal [user.email], mail.to
    assert_equal ['from@example.com'], mail.from
    assert_match user.reset_token, mail.body.encoded
  end

end
