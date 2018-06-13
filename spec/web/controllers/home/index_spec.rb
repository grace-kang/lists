require_relative '../../../spec_helper'

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

    @this_user = user.create(email: 'email', hashed_pass: hashed_password('pass'), email_confirmed: true, token: 'token')
    @list = list.create(name: 'Groceries', user_id: @this_user.id, done: false)
    @item = item.create(text: 'Fudge ingredients', list_id: @list.id, done: false)
    @subitem = subitem.create(text: 'Flour', item_id: @item.id, done: false)
  end

  describe 'not logged in' do
    let(:params) { Hash[] }

    it 'redirects to root' do
      response = action.call(params)
      response[0].must_equal 302
      response[1]['Location'].must_equal '/'
    end
  end
end
