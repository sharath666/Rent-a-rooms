require 'test_helper'

class NotificationTest < ActionMailer::TestCase
  test "authorize_confirmation" do
    mail = Notification.authorize_confirmation
    assert_equal "Authorize confirmation", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
