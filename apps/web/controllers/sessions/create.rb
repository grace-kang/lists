module Web::Controllers::Sessions
  class Create
    include Web::Action

    def call(params)
      email = params[:session][:email]
      password = params[:session][:password]

      @user = UserRepository.new.find_by_email(email)
      login("You have been successfully logged in.") if authenticated?(password)
      redirect_to '/home/index'
    end
  end
end
