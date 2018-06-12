require_relative '../../../spec_helper'

describe Web::Controllers::Users::Create do
  let(:action) { Web::Controllers::Users::Create.new }
  include Import['repositories.user']
  include Hanami::Tachiban

  before do
    user.clear
  end

  describe 'with valid params' do
    let(:params) { Hash[user: { email: 'email@email.com', password: 'pass', password_confirmation: 'pass'}] }
    it 'creates a new user' do
      action.call(params)
      @user = user.last

      @user.id.wont_be_nil
      @user.email.must_equal params.dig(:user, :email)
      authenticated?(params.dig(:user, :password)).must_equal true
    end

    it 'redirects to root' do
      response = action.call(params)

      response[0].must_equal 302
      response[1]['Location'].must_equal '/'
    end
  end

  describe 'with invalid params' do
    let(:params) { Hash[user: {}] }

    it 'dumps errors in flash' do
      action.call(params)
      errors = action.exposures[:flash][:input_errors]

      errors[0].must_equal 'Email is missing'
      errors[1].must_equal 'Password is missing'
    end

    it 'redirects to signup page' do
      response = action.call(params)
      
      response[0].must_equal 302
      response[1]['Location'].must_equal '/users/new'
    end
  end
end
