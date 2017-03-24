class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #

  def alert_email_upcoming(user, alert)

    @user = user
    @alert = alert
    mail to: user.email, subject: "iShelter - Upcoming: " + alert.title
  end
  def alert_email_overdue(user, alert)
    @user = user
    @alert = alert
    mail to: user.email, subject: "iShelter - OVERDUE: " + alert.title
  end
  def alert_email_assigned(user, alert)
    @user = user
    @alert = alert
    mail to: user.email, subject: "iShelter - Assigned: " + alert.title
  end
  def alert_email_edited(user, alert)
    @user = user
    @alert = alert
    mail to: user.email, subject: "iShelter - Edited: " + alert.title
  end
  def account_activation(user, current_user)
    @current_user = current_user
    @user = user
    mail to: user.email, subject: "iShelter - Account activation"
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
