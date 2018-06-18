require_relative '../../spec_helper'

describe UserRepository do
  include Hanami::Tachiban
  include Import['repositories.list']

  before do
    @repository = UserRepository.new
    @repository.clear

    @user = @repository.create(email: 'email', hashed_pass: hashed_password('pass'), email_confirmed: true, token: 'token')
  end

  it 'creates a new user with attributes' do
    last_user = @repository.last

    last_user.id.wont_be_nil
    last_user.email.must_equal 'email'
  end

  it 'finds a user by email' do
    found_user = @repository.find_by_email('email')

    found_user.id.wont_be_nil
    found_user.id.must_equal @user.id
  end

  it 'finds a user by token' do
		found_user = @repository.find_by_token('token')
		
		found_user.id.wont_be_nil
		found_user.id.must_equal @user.id
  end
end
