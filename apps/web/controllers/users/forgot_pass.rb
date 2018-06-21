module Web::Controllers::Users
  class ForgotPass
    include Web::Action
		include Import['repositories.user']

    def call(params); end
  end
end
