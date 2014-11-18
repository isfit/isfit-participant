require 'test_helper'

class InformationMailerTest < ActionMailer::TestCase
  test "new_questions" do
    mail = InformationMailer.new_questions
    assert_equal "New questions", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
