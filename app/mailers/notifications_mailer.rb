class NotificationsMailer < ApplicationMailer
    default :from => 'dont-reply@tripstore.com'
     # send a signup email to the user, pass in the user object that   contains the user's email address
    def password_reset(user)
        @user = user
        mail( :to => @user.email,
        :subject => 'Password Token' )
    end
end
