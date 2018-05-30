module Web::Controllers::Users
  class Create
    include Web::Action

    params do
      required(:user).schema do
        required(:email).filled(:str?)
        required(:password).filled(:str?).confirmation
      end
    end

    def call(params)
      @error_messages = []

      if params.valid?
        password = params[:user][:password]
        email = params[:user][:email]
        hashed_pass = hashed_password(password)
        repository = UserRepository.new
        
        if repository.find_by_email(email)
          flash[:email] = 'That email has been taken. Please try again.'
          redirect_to '/users/signup'
        else
          @user = repository.create(email: email, hashed_pass: hashed_pass)
					flash[:signup_success] = "Successfully signed up! Please log in."
          redirect_to '/'
        end

      else
        flash[:input_errors] = params.error_messages
        redirect_to '/users/signup'
      end
    end
  end
end
