require_relative '../../../spec_helper'

describe Web::Controllers::Subitem::Unmark do
  let(:action) { Web::Controllers::Subitem::Unmark.new }
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
    @list = list.create(user_id: @user.id, name: 'Groceries', done: false, position: 0)
    @item = item.create(list_id: @list.id, text: 'Cake', done: false, position: 0)
    @sugar = subitem.create(item_id: @item.id, text: 'Sugar', done: true, position: 0)
  end

  describe 'given the marked subitems id' do
    let(:params) { Hash[unmark_subitem: { id: @sugar.id }] }

    it 'unmarks the subitem and redirects to index' do
      response = action.call(params)
      updated_subitem = subitem.find(@sugar.id)

      updated_subitem.done.must_equal false
      response[0].must_equal 302
      response[1]['Location'].must_equal '/home/index'
    end
  end
end
