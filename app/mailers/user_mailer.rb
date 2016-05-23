class UserMailer < ActionMailer::Base
	default from: "bo@zwaig.com"

	def verify_email(user)
		@user = user
  		@url  = "localhost:3000/users/email_verification/#{@user.email_token}"
  		mail(to: @user.email, subject: "Please verify your email homie!")
	end
end
