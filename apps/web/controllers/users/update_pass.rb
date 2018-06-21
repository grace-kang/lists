module Web::Controllers::Users
  class UpdatePass
    include Web::Action
		include Import['repositories.user']

    def call(params)
			user.update(params[:new_pass][:id], hashed_pass: hashed_password(params[:new_pass][:password]))
			flash[:pass_updated] = 'Password successfully changed! Please log in.'
			redirect_to '/'
    end
  end
end
