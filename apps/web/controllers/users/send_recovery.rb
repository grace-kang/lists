module Web::Controllers::Users
  class SendRecovery
    include Web::Action
		include Import['repositories.user']

    def call(params)
			this_user = user.find_by_email(params[:user][:email])
			if this_user and this_user.email_confirmed
				Mailers::ForgotPass.deliver(user: this_user)
				flash[:message] = 'Password recovery link delivered! Please check your inbox'
			else
				flash[:message] = 'Invalid or unconfirmed email'
			end
			redirect_to '/'
    end
  end
end
