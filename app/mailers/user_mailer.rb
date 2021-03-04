class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.passwords_reset.subject
  #
  def passwords_reset(user)
    @user = user
    mail to: user.email, subject: 'Newport Marine Detailing Password Reset'
  end
end
