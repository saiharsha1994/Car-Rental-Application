require 'test_helper'

class NotifyMailerTest < ActionMailer::TestCase
  test "new_notify" do
    mail = NotifyMailer.new_notify
    assert_equal "New notify", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
