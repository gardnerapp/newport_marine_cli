require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: 'Corey', email: 'lookyouhog@example.com',
                     phone: '4018887777', password: 'foobar',
                     password_confirmation: 'foobar')

  end

  # Error here ??
  test 'should be valid' do
    assert @user.valid?
  end

  test 'name should be present' do
    @user.name = '     '
    assert_not @user.valid?, 'name presence validation'
  end

  test 'email should be present' do
    @user.email = '   '
    assert_not @user.valid?, 'Email presence validation'
  end
  
  test 'name should not be too long' do
    @user.name = 'a'* 51
    assert_not @user.valid?, 'name length validation'
  end

  test 'email should not be too long' do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?, 'email length validation'
  end

  test 'email should be unique' do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?, "Email Uniqueness validation failed "
  end

  test 'email should be saved as downcase' do
    mixed_case_email = "F00Bartwenty@example.com"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email, "Downcasing b4 save failed "
  end

  test 'phone number should be present' do
    @user.phone = "   "
    assert_not @user.valid?, "Phone presence validation failed"
  end

  # TODO Write Test for Phone Number Uniqueness
  # test 'phone should be unique' do
  #   duplicate_user = @user.dup
  #   @user.save
  #   duplicate_user.phone = "4018887777"
  #   assert_not duplicate_user.valid?
  # end

  test 'password should be present (nonblank)'do
    @user.password_digest = @user.password_confirmation = "   "
    assert_not @user.valid?, "Password presence validation failed /"
  end

  test 'password should have minimum length' do
    @user.password_digest = @user.password_confirmation = "a" *5
    assert_not @user.valid?
  end

end
