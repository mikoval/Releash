class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #

  def alert_email(user, alert)
    @user = user
    @alert = alert
    mail to: user.email, subject: "iShelter: " + alert.title
  end
  def alert_email_overdue(user, alert)
    @user = user
    @alert = alert
    mail to: user.email, subject: "iShelter - OVERDUE: " + alert.title
  end
  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Account activation"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Password reset"
  end
end
