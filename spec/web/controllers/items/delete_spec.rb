require_relative '../../../spec_helper'

describe Web::Controllers::Items::Delete do
  include Hanami::Tachiban
  include Import['repositories.user']
  include Import['repositories.list']
  include Import['repositories.item']
  let(:action) { Web::Controllers::Items::Delete.new }

  before do
    user.clear
    list.clear
    item.clear

    @user = user.create(email: 'test', hashed_pass: hashed_password('pass'), email_confirmed: true, token: 'token')
    @list = list.create(user_id: @user.id, name: 'Groceries', done: false)
    @this_item = item.create(list_id: @list.id, text: 'Mushrooms', done: false)
  end

  describe 'with valid item_id' do
    let(:params) { Hash[delete_item: { id: @this_item.id }] }

    it 'deletes the item and redirects to home' do
      response = action.call(params)

      item.find(@this_item.id).must_be_nil
      response[0].must_equal 302
      response[1]['Location'].must_equal '/home/index'
    end
  end
end
