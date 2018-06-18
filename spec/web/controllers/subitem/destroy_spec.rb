require_relative '../../../spec_helper'

describe Web::Controllers::Subitem::Destroy do
  let(:action) { Web::Controllers::Subitem::Destroy.new }
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
    @item = item.create(list_id: @list.id, text: 'Cake', done: false)
    @flour = subitem.create(item_id: @item.id, text: 'Flour', done: false)
  end

  describe 'given the subitem id' do
    let(:params) { Hash[delete_subitem: { id: @flour.id }] }

    it 'deletes the subitem' do
      subitem.find(@flour.id).wont_be_nil
      action.call(params)
      subitem.find(@flour.id).must_be_nil
    end

    it 'redirects to index' do
      response = action.call(params)
      response[0].must_equal 302
      response[1]['Location'].must_equal '/home/index'
    end
  end
end
