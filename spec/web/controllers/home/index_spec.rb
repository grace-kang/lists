require_relative '../../../spec_helper'

describe Web::Controllers::Home::Index do
  let(:action) { Web::Controllers::Home::Index.new }
  let(:params) { Hash[SESSION_KEY: {}]}
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

    @this_user = user.create(email: 'email', hashed_pass: hashed_password('pass'))
    @list = list.create(name: 'Groceries', user_id: @this_user.id)
    @item = item.create(text: 'Fudge ingredients', list_id: @list.id, done: false)
    @subitem = subitem.create(text: 'Flour', item_id: @item.id, done: false)
  end

  describe 'logged in' do
    let(:params) { Hash[session: {current_user: @this_user}] }

    it 'is successful' do
      response = action.call(params)
      response[0].must_equal 200
    end

    it 'exposes all lists, items, and subitems' do
      action.call(params)
      exposed_lists = action.exposures[:lists]
      exposed_lists.must_equal [@list]
      exposed_lists.items.must_equal [@item]
      exposed_lists.items.subitems.must_equal [@subitem]
    end
  end
end

