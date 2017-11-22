class Notification < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification.authorize_confirmation.subject
  #
  def authorize_confirmation(room)
      @room = room
    mail to: "#{@room.user.email}", subject: "room is authorized confirmed - #{@room.user.username}"
  end
  def booking_confirmation(booking)
  	@booking = booking
  	mail to: "#{@booking.user.email}", subject: "room booking in #{@booking.room.name}-#{@booking.user.username}"
end
def rooms_confirmation(booking)
  @booking = booking
  mail to: "#{@booking.room.user.email}", subject: "a booking has been on yr #{@booking.room.name}"
end
end