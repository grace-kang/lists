module Web::Controllers::Users
  class NewPass
    include Web::Action
		include Import['repositories.user']
		
		expose :this_user

    def call(params)
			@this_user = user.find_by_token(params[:token])
    end
  end
end
