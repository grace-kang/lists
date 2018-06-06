require_relative '../../spec_helper'

describe Item do
  include Hanami::Tachiban
  include Import['repositories.user']
  include Import['repositories.list']

  before do
    user.clear
    list.clear

    @user = user.create(email: 'email', hashed_pass: hashed_password('pass'))
    @list = list.create(user_id: @user.id, name: 'Groceries')
  end

  it 'can be initialized with text' do
    item = Item.new(list_id: @list.id, text: 'Mushroom', done: false)
    item.text.must_equal 'Mushroom'
  end
end
