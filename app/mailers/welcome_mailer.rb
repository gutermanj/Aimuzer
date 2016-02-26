class WelcomeMailer < ApplicationMailer

	default from: "gutermanj@gmail.com"

	def welcome_email(user)	
		@user = user
		mail(to: @user.email, subject: "Welcome, #{@user.first_name}")
	end

end
