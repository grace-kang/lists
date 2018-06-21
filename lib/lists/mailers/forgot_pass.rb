class Mailers::ForgotPass
  include Hanami::Mailer

  from    'listswebapp@gmail.com'
  to      :recipient
  subject 'Password Recovery'

	private
	
	def recipient
		user.email
	end
end
