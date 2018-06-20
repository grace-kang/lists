require_relative '../../../spec_helper'

describe Web::Controllers::Items::UpdateOrder do
	include Import['repositories.user']
	include Import['repositories.list']
	include Import['repositories.item']
	include Import['repositories.subitem']
  let(:action) { Web::Controllers::Items::UpdateOrder.new }

	before do
		user.clear
		list.clear

    @user = user.create(email: 'email', hashed_pass: hashed_password('pass'), email_confirmed: true, token: 'token')
    @list1 = list.create(user_id: @user.id, name: 'Groceries', done: false, position: 0)
		@item1 = item.create(list_id: @list1.id, text: 'item1', done: false, position: 0)
		@subitem1 = subitem.create(item_id: @item1.id, text: 'subitem1', done: false, position: 0)
		@subitem2 = subitem.create(item_id: @item1.id, text: 'subitem2', done: true, position: 0)

    @list2 = list.create(user_id: @user.id, name: 'To Do', done: false, position: 0)
		@item2 = item.create(list_id: @list2.id, text: 'item2', done: false, position: 0)
		@subitem3 = subitem.create(item_id: @item2.id, text: 'subitem3', done: false, position: 0)
		@subitem4 = subitem.create(item_id: @item2.id, text: 'subitem4', done: true, position: 0)
	end
		
	describe 'updating list1' do
		let(:params) { Hash[order: "{\"#{ @subitem1.id }\":1, \"#{ @subitem2.id }\":0}" ] }

		it 'updates the subitem positions from list1 and redirects to index' do
			response = action.call(params)

			subitem.find(@subitem1.id).position.must_equal 1
			subitem.find(@subitem2.id).position.must_equal 0
			response[0].must_equal 302 
			response[1]['Location'].must_equal '/home/index'
		end
	end

	describe 'updating list2' do
		let(:params) { Hash[order: "{\"#{ @subitem3.id }\":1, \"#{ @subitem4.id }\":0}" ] }

		it 'updates the subitem positions from list2 and redirects to index' do
			response = action.call(params)

			subitem.find(@subitem3.id).position.must_equal 1
			subitem.find(@subitem4.id).position.must_equal 0
			response[0].must_equal 302
			response[1]['Location'].must_equal '/home/index'
		end
	end
end
