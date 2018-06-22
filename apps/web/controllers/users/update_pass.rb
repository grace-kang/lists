module Web::Controllers::Users
  class UpdatePass
    include Web::Action
		include Import['repositories.user']

	params do
		required(:new_pass).schema do
			required(:id).filled(:str?)
			required(:old_pass).filled(:str?)
			required(:token).filled.(str?)
			required(:password).filled(:str?).confirmation
		end
	end

    def call(params)
			if params.valid?
				user_repo = user
				@user = user.find(params[:new_pass][:id])
				if !authenticated?(params[:new_pass][:password])
					user_repo.update(params[:new_pass][:id], hashed_pass: hashed_password(params[:new_pass][:password]))
					flash[:pass_updated] = 'Password successfully changed! Please log in.'
					redirect_to '/'
				else
					flash[:input_errors] = ['Your new password cannot be the same as your old password']
					redirect_to routes.new_pass_path(params[:new_pass][:token])
				end

			else
				flash[:input_errors] = params.error_messages
				redirect_to routes.new_pass_path(params[:new_pass][:token])
			end
    end
  end
end
