require_relative '../../../spec_helper'

describe Web::Controllers::Lists::UpdateOrder do
	include Import['repositories.user']
	include Import['repositories.list']
	include Import['repositories.item']
  let(:action) { Web::Controllers::Lists::UpdateOrder.new }

	before do
		user.clear
		list.clear
		item.clear

    @user = user.create(email: 'email', hashed_pass: hashed_password('pass'), email_confirmed: true, token: 'token')
    @list1 = list.create(user_id: @user.id, name: 'Groceries', done: false, position: 0)
    @item1 = item.create(list_id: @list1.id, text: 'item1', done: false, position: 0)
		@item2 = item.create(list_id: @list1.id, text: 'item2', done: false, position: 1)

		@list2 = list.create(user_id: @user.id, name: 'list2', done: false, position: 1)
		@item3 = item.create(list_id: @list2.id, text: 'item3', done: false, position: 0)
		@item4 = item.create(list_id: @list2.id, text: 'item4', done: false, position: 1)
	end

  describe 'updating list1' do
		let(:params) { Hash[order: "{\"#{ @item1.id }\":1, \"#{ @item2.id }\":0}" ] }

		it 'updates the item positions and redirects to index' do
	    response = action.call(params)

			item.find(@item1.id).position.must_equal 1
			item.find(@item2.id).position.must_equal 0
			response[0].must_equal 302
			response[1]['Location'].must_equal '/home/index'
		end
  end

	describe 'updating list2' do
		let(:params) { Hash[order: "{\"#{ @item3.id }\":1, \"#{ @item4.id }\":0}" ] }

		it 'updates the item positions and redirects to index' do
			response = action.call(params)

			item.find(@item3.id).position.must_equal 1
			item.find(@item4.id).position.must_equal 0
			response[0].must_equal 302
			response[1]['Location'].must_equal '/home/index'
		end
	end
end
