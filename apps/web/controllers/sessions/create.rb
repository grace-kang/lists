module Web::Controllers::Sessions
  class Create
    include Web::Action
    include Import['repositories.user']

    def call(params)
      email = params[:session][:email]
      password = params[:session][:password]

      @user = user.find_by_email(email)
      if authenticated?(password)
        if @user.email_confirmed
          login('Success')
          redirect_to '/home/index'
        else
          flash[:login_error] = 'Please check your email to confirm your registration.'
          redirect_to routes.path(:new_session)
        end
      else
        flash[:login_error] = 'Log in failed. Please try again.'
        redirect_to routes.path(:new_session)
      end
    end
  end
end
