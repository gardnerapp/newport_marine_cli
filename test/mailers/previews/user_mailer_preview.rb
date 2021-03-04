# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/passwords_reset
  def passwords_reset
    user = User.first
    user.reset_token = User.new_token
    UserMailer.passwords_reset user
  end

end
