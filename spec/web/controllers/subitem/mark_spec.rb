require_relative '../../../spec_helper'

describe Web::Controllers::Subitem::Mark do
  let(:action) { Web::Controllers::Subitem::Mark.new }
  include Hanami::Tachiban
  include Import['repositories.user']
  include Import['repositories.list']
  include Import['repositories.item']
  include Import['repositories.subitem']

  before do
    user.clear
    list.clear
    item.clear
    subitem.clear

    @user = user.create(email: 'email', hashed_pass: hashed_password('pass'), email_confirmed: true, token: 'token')
    @list = list.create(user_id: @user.id, name: 'Groceries', done: false)
    @item = item.create(list_id: @list.id, text: 'Cake', done: false)
    @flour = subitem.create(item_id: @item.id, text: 'Flour', done: false)
  end

  describe 'given the subitem id' do
    let(:params) { Hash[mark_subitem: { id: @flour.id }] }

    it 'marks the item as done and redirects to index' do
      response = action.call(params)
      updated_subitem = subitem.find(@flour.id)

      updated_subitem.done.must_equal true
      response[0].must_equal 302
      response[1]['Location'].must_equal '/home/index'
    end
  end
end
