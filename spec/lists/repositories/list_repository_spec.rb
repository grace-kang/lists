require_relative '../../spec_helper'

describe ListRepository do
  include Hanami::Tachiban
  include Import['repositories.user']
  include Import['repositories.item']

  before do
    @repository = ListRepository.new
    
    @repository.clear
    user.clear
    item.clear

    @this_user = user.create(email: 'test', hashed_pass: hashed_password('pass'), email_confirmed: true, token: 'token')
    @new_list = @repository.create(name: 'Groceries', user_id: @this_user.id)
  end

  it 'can create a new list' do
    @last_list = @repository.last

    @last_list.id.wont_be_nil
    @last_list.id.must_equal @new_list.id
    @last_list.user_id.must_equal @this_user.id
    @last_list.name.must_equal 'Groceries'
  end

  it 'can find all items associated to a list_id' do
    item.create(list_id: @new_list.id, text: 'Mushrooms', done: false)
    groceries = @repository.find_items(@new_list.id)

    groceries.items.last.text.must_equal 'Mushrooms'
  end
end
