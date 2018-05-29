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
      if params.valid?
        password = params[:user][:password]
        email = params[:user][:email]
        hashed_pass = hashed_password(password)
        repository = UserRepository.new
      
        @user = repository.create(email: email, hashed_pass: hashed_pass)

        redirect_to '/'
      else
        self.status = 422
      end
    end
  end
end
