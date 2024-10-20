class UserMailer < ApplicationMailer
    default from: ENV['GMAIL_USERNAME']

    def welcome_email(user)
        @user = user 
        mail(to: @user.email, subject: 'Welcome to Bricolage')
    end 
end
