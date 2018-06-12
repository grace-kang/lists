require_relative '../../../spec_helper'

describe Web::Controllers::Lists::Create do
  let(:action) { Web::Controllers::Lists::Create.new }
  include Import['repositories.user']
  include Import['repositories.list']

  before do
    user.clear
    list.clear

    @new_user = user.create(email: 'test', hashed_pass: 'test', email_confirmed: true, token: 'token')
  end

  describe 'with valid params' do
    let(:params) { Hash[new_list: { name: 'Groceries', user_id: @new_user.id }] }
    it 'creates a new list' do
      action.call(params)
      new_list = list.last

      new_list.id.wont_be_nil
      new_list.name.must_equal params.dig(:new_list, :name)
    end

    it 'redirects the user to the home page' do
      response = action.call(params)

      response[0].must_equal 302
      response[1]['Location'].must_equal '/home/index'
    end
  end

  describe 'with invalid params' do
    let(:params) { Hash[list: {}] }

    it 'redirects to index' do
      response = action.call(params)

      response[0].must_equal 302
      response[1]['Location'].must_equal '/home/index'
    end
  end
end
