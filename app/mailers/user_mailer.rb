class UserMailer < ApplicationMailer
  default from: "finanfantasy13@gmail.com"

  def notify_new_follower(user, follower)
    @user = user
    @follower = follower
    mail(to: "#{user.name} <#{user.email}>", subject: "#{follower.name} has followed you")
  end
end
