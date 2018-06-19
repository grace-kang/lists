require_relative '../../../spec_helper'

describe Web::Controllers::Items::Mark do
  let(:action) { Web::Controllers::Items::Mark.new }
  include Import['repositories.user']
  include Import['repositories.list']
  include Import['repositories.item']
  include Hanami::Tachiban

  before do
    user.clear
    list.clear
    item.clear

    @user = user.create(email: 'test', hashed_pass: hashed_password('pass'), email_confirmed: true, token: 'token')
    @list = list.create(user_id: @user.id, name: 'Groceries', done: false, position: 0)
    @this_item = item.create(list_id: @list.id, text: 'Mushrooms', done: false, position: 0)
  end

  let(:params) { Hash[mark_item: { id: @this_item.id }] }

  it 'marks item and redirects to index' do
    response = action.call(params)
    @this_item = item.find(@this_item.id)

    @this_item.done.must_equal true
    response[0].must_equal 302
    response[1]['Location'].must_equal '/home/index'
  end
end
