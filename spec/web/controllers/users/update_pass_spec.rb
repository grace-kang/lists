require_relative '../../../spec_helper'

describe Web::Controllers::Users::UpdatePass do
  let(:action) { Web::Controllers::Users::UpdatePass.new }
	include Hanami::Tachiban
	include Import['repositories.user']

	before do
		user.clear

		@this_user = user.create(email: 'email', hashed_pass: hashed_password('pass'), email_confirmed: true, token: 'token')
	end

  describe 'with valid params' do
  	let(:params) { Hash[new_pass: { id: @this_user.id, old_pass: @this_user.hashed_pass, token: @this_user.token, password: 'newpass', password_confirmation: 'newpass'}] }

		it 'updates the users password and redirects to root' do
			response = action.call(params)

			@user = user.find(@this_user.id)
			@user.id.wont_be_nil
			authenticated?(params[:new_pass][:password]).must_equal true
			action.exposures[:flash][:message].must_include 'Password successfully changed'
			response[0].must_equal 302
			response[1]['Location'].must_equal '/'
		end	
  end

	describe 'with invalid params' do
		let(:params) { Hash[new_pass: { id: @this_user.id, old_pass: @this_user.hashed_pass, token: @this_user.token}] }

		it 'sets input errors and redirects to same page' do
			response = action.call(params)

			errors = action.exposures[:flash][:input_errors]
			errors[0].must_equal 'Password is missing'
			response[0].must_equal 302
			response[1]['Location'].must_equal '/users/new_pass/token'
		end
	end
end
