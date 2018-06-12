require_relative '../../spec_helper'

describe User do
  before do
    @repository = UserRepository.new
    @repository.clear
  end

  it 'can be initialized with an email and hashed_pass' do
    user = @repository.create(email: 'test', hashed_pass: 'pass', email_confirmed: true, token: 'token')
  
    user.email.must_equal 'test'
    user.hashed_pass.must_equal 'pass'
  end
end
