require_relative '../../spec_helper'

describe ItemRepository do
  include Hanami::Tachiban
  include Import['repositories.user']
  include Import['repositories.list']
  include Import['repositories.subitem']

  before do
    user.clear
    list.clear

    @repository = ItemRepository.new
    @repository.clear

    @user = user.create(email: 'test', hashed_pass: hashed_password('pass'))
    @list = list.create(user_id: @user.id, name: 'Groceries')
  end

  it 'creates an item with attributes' do
    item = @repository.create(list_id: @list.id, text: 'Mushrooms', done: false)
    last_item = @repository.last

    last_item.id.wont_be_nil
    last_item.text.must_equal item.text
  end

  it 'finds subitems associated to item id' do
    cake = @repository.create(list_id: @list.id, text: 'Cake', done: false)
    flour = subitem.create(item_id: cake.id, text: 'Flour', done: false)
    cake = @repository.find_subitems(cake.id)

    cake.subitems.must_include flour
  end
end
