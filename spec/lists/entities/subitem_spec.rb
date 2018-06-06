require_relative '../../spec_helper'

describe Subitem do
  include Hanami::Tachiban
  include Import['repositories.user']
  include Import['repositories.list']
  include Import['repositories.item']

  before do
    user.clear
    list.clear
    item.clear

    @user = user.create(email: 'email', hashed_pass: hashed_password('pass'))
    @list = list.create(user_id: @user.id, name: 'Groceries')
    @item = item.create(list_id: @list.id, text: 'Cake', done: false)
  end

  it 'can be initialized with text' do
    subitem = SubitemRepository.new.create(item_id: @item.id, text: 'Flour', done: false)  

    subitem.text.must_equal 'Flour'
  end
end