class Mailers::ForgotPass
  include Hanami::Mailer
	include Hanami::Helpers

  from    'listswebapp@gmail.com'
  to      :recipient
  subject 'Password Recovery'

	def recipient
		user.email
	end
end
