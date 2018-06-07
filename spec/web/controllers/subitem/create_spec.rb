require_relative '../../../spec_helper'

describe Web::Controllers::Subitem::Create do
  let(:action) { Web::Controllers::Subitem::Create.new }
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

    @user = user.create(email: 'email', hashed_pass: hashed_password('pass'))
    @list = list.create(user_id: @user.id, name: 'Groceries')
    @item = item.create(list_id: @list.id, text: 'Cake Ingredients', done: false)
  end

  describe 'with valid params' do
    let(:params) { Hash[newsubitem: {item_id: @item.id, text: 'Sugar', done: false}] }

    it 'creates a new subitem' do
      action.call(params)
      last_subitem = subitem.last

      last_subitem.id.wont_be_nil
      last_subitem.item_id.must_equal params.dig(:newsubitem, :item_id)
      last_subitem.text.must_equal params.dig(:newsubitem, :text)
    end

    it 'redirects to index' do
      response = action.call(params)
      response[0].must_equal 302
      response[1]['Location'].must_equal '/home/index' 
    end
  end

  describe 'with invalid params' do
    let(:params) { Hash[] }

    it 'redirects to index' do
      response = action.call(params)
      response[0].must_equal 302
      response[1]['Location'].must_equal '/home/index'
    end
  end
end
