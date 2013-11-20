class UserMailer < ActionMailer::Base
  default from: "\"Blog Secret Santa\" <secretsanta@csworkflow.com>"

  def match_notification(giver, receiver)
    @giver = giver
    @receiver = receiver
    mail to: giver.email, subject: "The Blog Secret Santa that you've drawn" 
  end
  
  def send_gift(user, content)
    @user = user
    @content = content
    mail to: user.email, subject: "Your Blog Secret Santa content gift"
  end
end
