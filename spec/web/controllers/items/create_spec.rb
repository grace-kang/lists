require_relative '../../../spec_helper'

describe Web::Controllers::Items::Create do
  let(:action) { Web::Controllers::Items::Create.new }
  include Import['repositories.user']
  include Import['repositories.list']
  include Import['repositories.item']

  before do
    user.clear
    list.clear
    item.clear

    @this_user = user.create(email: 'test', hashed_pass: 'test')
    @new_list = list.create(name: 'Groceries', user_id: @this_user.id)
  end

  describe 'with valid params' do
    let(:params) { Hash[newitem: { list_id: @new_list.id, text: 'Mushrooms', done: false }] }

    it 'creates a new item' do
      action.call(params)
      new_item = item.last

      new_item.id.wont_be_nil
      new_item.text.must_equal params.dig(:newitem, :text)
      @new_list = list.find_items(@new_list.id)
      @new_list.items.must_equal [new_item]
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

