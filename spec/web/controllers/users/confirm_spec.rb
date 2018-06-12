require_relative '../../../spec_helper'

describe Web::Controllers::Users::Confirm do
  let(:action) { Web::Controllers::Users::Confirm.new }
  include Import['repositories.user']

  before do
    user.clear

    @this_user = user.create(email: 'email', hashed_pass: hashed_password('pass'), email_confirmed: true, token: 'token')
  end

  describe 'user exists' do
    let(:params) { Hash[token: @this_user.token] }

    it 'successfully confirms email and redirects to root' do
      response = action.call(params)
      user1 = user.find(@this_user.id)

      user1.email_confirmed.must_equal true
      action.exposures[:flash][:confirmed].must_equal 'Successfully confirmed email! You may log in.'
      response[1]['Location'].must_equal '/'
    end
  end

  describe 'user doesnt exist' do
    let(:params) { Hash[token: 'doesnt exist'] }

    it 'returns an error and redirects to root' do
      response = action.call(params)

      action.exposures[:flash][:error].must_equal 'Error confirming email.'
      response[1]['Location'].must_equal '/'
    end
  end
end
