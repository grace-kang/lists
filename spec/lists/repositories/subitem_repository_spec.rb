require_relative '../../spec_helper.rb'

describe SubitemRepository do
  include Hanami::Tachiban
  include Import['repositories.user']
  include Import['repositories.list']
  include Import['repositories.item']

  before do
    @repository = SubitemRepository.new
    @repository.clear

    user.clear
    list.clear
    item.clear

    @user = user.create(email: 'test', hashed_pass: hashed_password('pass'), email_confirmed: true, token: 'token')
    @list = list.create(user_id: @user.id, name: 'Groceries', done: false)
    @item = item.create(list_id: @list.id, text: 'Cake', done: false)
  end

  it 'creates a new subitem' do
    @repository.create(item_id: @item.id, text: 'Flour', done: false)
    last_subitem = @repository.last

    last_subitem.id.wont_be_nil
    last_subitem.item_id.must_equal @item.id
    last_subitem.text.must_equal 'Flour'
  end
end
