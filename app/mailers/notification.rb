class Notification < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification.authorize_confirmation.subject
  #
  def authorize_confirmation(room)
      @room = room
    mail to: "#{@room.user.email}", subject: "Order confirmed - #{@room.user.username}"
  end
end
