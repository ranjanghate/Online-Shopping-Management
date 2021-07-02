class SignUpMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    @url  = 'http://localhost:3000/signin'
    mail(to: @user.email, subject: 'Welcome to Elearning')
  end
end
