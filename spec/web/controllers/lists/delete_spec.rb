require_relative '../../../spec_helper'

describe Web::Controllers::Lists::Delete do
  let(:action) { Web::Controllers::Lists::Delete.new }
  include Hanami::Tachiban
  include Import['repositories.user']
  include Import['repositories.list']

  before do
    user.clear
    list.clear

    @user = user.create(email: 'test', hashed_pass: hashed_password('pass'), email_confirmed: true, token: 'token')
    @this_list = list.create(user_id: @user.id, name: 'Groceries')
  end

  let(:params) { Hash[delete_list: {id: @this_list.id}] }

  it 'deletes the list and redirects to index' do
    response = action.call(params)

    list.find(@this_list.id).must_be_nil
    response[0].must_equal 302
    response[1]['Location'].must_equal '/home/index'
  end
end
