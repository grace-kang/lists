module Web::Controllers::Sessions
  class Create
    include Web::Action

    def call(params)
      email = params[:session][:email]
      password = params[:session][:password]

      @user = UserRepository.new.find_by_email(email)
      if authenticated?(password)
        login('Success')
        redirect_to '/home/index'
      else
        flash[:login_error] = 'Log in failed. Please try again.'
        redirect_to '/sessions/new'
      end
    end
  end
end
