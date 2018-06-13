require_relative '../../../spec_helper'

describe Web::Controllers::Lists::Unmark do
  let(:action) { Web::Controllers::Lists::Unmark.new }
  include Import['repositories.user']
  include Import['repositories.list']

  before do
    user.clear
    list.clear

    @user = user.create(email: 'test', hashed_pass: hashed_password('pass'), email_confirmed: true, token: 'token')
    @this_list = list.create(user_id: @user.id, name: 'Groceries', done: true)
  end

  let(:params) { Hash[unmark_list: { id: @this_list.id }] }

  it 'marks list and redirects to index' do
    response = action.call(params)
    @this_list = list.find(@this_list.id)

    @this_list.done.must_equal false
    response[0].must_equal 302
    response[1]['Location'].must_equal '/home/index'
  end
end
