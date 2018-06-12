require_relative '../../../spec_helper'

describe Web::Controllers::Sessions::Create do
  let(:action) { Web::Controllers::Sessions::Create.new }
  include Hanami::Tachiban
  include Import['repositories.user']

  before do
    user.clear

    @user = user.create(email: 'test', hashed_pass: hashed_password('test'), email_confirmed: true, token: 'token')
  end

  describe 'with valid params' do
    let(:params) { Hash[session: { email: 'test', password: 'test' }] }

    it 'redirects to index' do
      response = action.call(params)
      response[0].must_equal 302 
      response[1]['Location'].must_equal '/home/index'
    end
  end

  describe 'with invalid params' do
    let(:params) { Hash[session: {}] }

    it 'dumps error message in flash' do
      action.call(params)
      error = action.exposures[:flash][:login_error]
      error.must_equal 'Log in failed. Please try again.'
    end

    it 'redirects to /sessions/new' do
      response = action.call(params)

      response[0].must_equal 302
      response[1]['Location'].must_equal '/sessions/new'
    end
  end
end
