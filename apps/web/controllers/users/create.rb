module Web::Controllers::Users
  class Create
    include Web::Action
    include Import['repositories.user']

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

        if user.find_by_email(email)
          flash[:email] = 'That email has been taken. Please try again.'
          redirect_to routes.path(:new_user)
        else
          token = SecureRandom.urlsafe_base64.to_s
          new_user = user.create(email: email, hashed_pass: hashed_pass, email_confirmed: false, token: token)
          Mailers::ConfirmEmail.deliver(user: new_user)
          flash[:message] = 'Successfully signed up! Please check your email to confirm your registration.'
          redirect_to routes.path(:root)
        end

      else
        flash[:input_errors] = params.error_messages
        redirect_to routes.path(:new_user)
      end
    end
  end
end
