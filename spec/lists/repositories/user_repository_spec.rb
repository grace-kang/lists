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
    found_user = @repository.find_by_email(@user.email)

    found_user.id.wont_be_nil
    found_user.id.must_equal @user.id
  end

  it 'finds lists associated to a user id' do
    groceries = list.create(user_id: @user.id, name: 'Groceries', done: false)
    todo = list.create(user_id: @user.id, name: 'To do', done: false)
    updated_user = @repository.find_lists(@user.id)

    updated_user.lists.must_include groceries
    updated_user.lists.must_include todo
  end
end
