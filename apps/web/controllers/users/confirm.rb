module Web::Controllers::Users
  class Confirm
    include Web::Action
    include Import['repositories.user']

    def call(params)
      this_user = user.find_by_token(params[:token])
      if this_user
        user.update(this_user.id, email_confirmed: true)
        flash[:confirmed] = 'Successfully confirmed email! You may log in.'
      else
        flash[:error] = 'Error confirming email.'
      end
      redirect_to '/'
    end
  end
end
