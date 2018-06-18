require_relative '../../../spec_helper'

describe Web::Controllers::Users::UpdateOrder do
	include Import['repositories.user']
	include Import['repositories.list']

	before do
		user.clear
		list.clear

		@user = user.create(email: 'email', hashed_pass: hashed_password('pass'), email_confirmed: true, token: 'token')
		@list1 = list.create(user_id: @user.id, name: 'Groceries', done: false, position: 0)
		@list2 = list.create(user_id: @user.id, name: 'To do', done: false, position: 1)
	end

  let(:action) { Web::Controllers::Users::UpdateOrder.new }
  let(:params) { Hash[order: "{\"#{ @list1.id }\":1, \"#{ @list2.id }\":0}" ] }

  it 'updates the list positions and redirects to index' do
    response = action.call(params)
		
		list.find(@list1.id).position.must_equal 1
		list.find(@list2.id).position.must_equal 0
    response[0].must_equal 302
		response[1]['Location'].must_equal '/home/index'
  end
end
