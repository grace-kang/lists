require_relative '../../spec_helper'

describe Mailers::ForgotPass do
	include Import['repositories.user']

	before do
		user.clear
		Hanami::Mailer.deliveries.clear

		@user = user.create(email: 'email', hashed_pass: hashed_password('pass'), email_confirmed: true, token: 'token')
	end

  it 'delivers email' do
    Mailers::ForgotPass.deliver(user: @user)
		mail = Hanami::Mailer.deliveries.last

		mail.to[0].must_equal @user.email
		mail.body.encoded.must_include "Hi #{@user.email},"
  end
end
