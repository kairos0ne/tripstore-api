class NotificationsMailer < ApplicationMailer
    default :from => 'any_from_address@example.com'
     # send a signup email to the user, pass in the user object that   contains the user's email address
    def password_reset(user)
        @user = user
        mail( :to => @user.email,
        :subject => 'Your new password token is contained within this email' )
    end
end
