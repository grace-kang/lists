require_relative '../../../spec_helper'

describe Web::Controllers::Items::Unmark do
  let(:action) { Web::Controllers::Items::Unmark.new }
  include Hanami::Tachiban
  include Import['repositories.user']
  include Import['repositories.list']
  include Import['repositories.item']

  before do
    user.clear
    list.clear
    item.clear

    @user = user.create(email: 'test', hashed_pass: hashed_password('pass'))
    @list = list.create(user_id: @user.id, name: 'Groceries')
    @this_item = item.create(list_id: @list.id, text: 'Mushrooms', done: true)
  end

  let(:params) { Hash[unmark_item: {id: @this_item.id}] }

  it 'unmarks item and redirects to index' do
    response = action.call(params)
    @this_item = item.find(@this_item.id)

    @this_item.done.must_equal false
    response[0].must_equal 302
    response[1]['Location'].must_equal '/home/index'
  end
end
