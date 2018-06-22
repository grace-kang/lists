require_relative '../../../spec_helper'

describe Web::Controllers::Users::SendRecovery do
  let(:action) { Web::Controllers::Users::SendRecovery.new }
	include Hanami::Tachiban
	include Import['repositories.user']

	before do
		user.clear

		@user = user.create(email: 'email', hashed_pass: 'pass', email_confirmed: true, token: 'token')
	end

  describe 'with a valid email' do
		let(:params) { Hash[user: { email: @user.email }] }

		it 'sends a password recovery email and redirects to root' do
			response = action.call(params)

			action.exposures[:flash][:message].must_equal 'Password recovery link delivered! Please check your inbox'
			response[0].must_equal 302
			response[1]['Location'].must_equal '/'
		end
  end

	describe 'with invalid email' do
		let(:params) { Hash[user: { email: 'invalidemail' }] }

		it 'sets flash and redirects to root' do
			response = action.call(params)

			action.exposures[:flash][:message].must_equal 'Invalid or unconfirmed email'
			response[0].must_equal 302
			response[1]['Location'].must_equal '/'
		end
	end
end
