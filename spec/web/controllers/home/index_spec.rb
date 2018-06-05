require_relative '../../../spec_helper'
require 'hanami/action/session'

describe Web::Controllers::Home::Index do
  let(:action) { Web::Controllers::Home::Index.new }
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

    @this_user = user.create(email: 'test', hashed_pass: hashed_password('pass'))
    @new_list = list.create(name: 'Groceries', user_id: @this_user.id)
    @new_item = item.create(text: 'Fudge ingredients', list_id: @new_list.id, done: false)
    @new_subitem = subitem.create(text: 'Flour', item_id: @new_item.id, done: false)
  end

  describe 'logged in' do
    let(:params) { Hash[index: {}] }

    it 'is successful' do
      response = action.call(params)
      response[0].must_equal 200
    end

    it 'exposes all lists, items, and subitems' do
      action.call(params)
      exposed_lists = action.exposures[:lists]
      exposed_lists.must_equal [@new_list]
      exposed_lists.items.must_equal [@new_item]
      exposed_lists.items.subitems.must_equal [@new_subitem]
    end
  end
end

