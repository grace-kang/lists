require_relative '../../spec_helper'

describe List do
  include Hanami::Tachiban
  include Import['repositories.user']

  before do
    user.clear
    @user = user.create(email: 'email', hashed_pass: hashed_password('pass'))
  end

  it 'can be initialized with a name' do
    list = List.new(user_id: @user.id, name: 'Groceries')
    list.name.must_equal 'Groceries'
  end
end
