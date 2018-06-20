require_relative '../../../spec_helper'

describe Web::Views::Home::Index do
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
	end

	let(:this_user) { user.create(email: 'email', hashed_pass: hashed_password('pass'), email_confirmed: true, token: 'token') }
	let(:exposures) { Hash[lists: [], this_user: this_user, items: {}, subitems: {}, params: {}] }
	let(:template)  { Hanami::View::Template.new('apps/web/templates/home/index.html.erb') }
	let(:view)      { Web::Views::Home::Index.new(template, exposures) }
	let(:rendered)  { view.render }

	it 'exposes #lists' do
		view.lists.must_equal exposures.fetch(:lists)
	end

	it 'exposes #this_user' do
		view.this_user.must_equal exposures.fetch(:this_user)
	end

	it 'exposes #items' do
		view.items.must_equal exposures.fetch(:items)
	end

	it 'exposes #subitems' do
		view.subitems.must_equal exposures.fetch(:subitems)
	end
describe 'when there are no lists' do
		it 'shows a placeholder message' do
			rendered.must_include('You do not have any lists yet.')
		end
	end

	describe 'when there are lists' do
		let(:this_user) { user.create(email: 'email', hashed_pass: hashed_password('pass'), email_confirmed: true, token: 'token') }
		let(:list1)     { list.create(user_id: this_user.id, name: 'Groceries', done: false, position: 0) }
  	let(:list2)     { list.create(user_id: this_user.id, name: 'Homework', done: false, position: 1) }
		let(:exposures) { Hash[lists: [list1, list2], this_user: this_user, items: { "#{ list1.id }": [], "#{ list2.id }": []}, subitems: {}, params: {}] }

		it 'lists them all' do
			rendered.must_include('Groceries')
			rendered.must_include('Homework')
		end

		it 'hides the placeholder message' do
			rendered.wont_include('You do not have any lists yet.')
		end

		describe 'when there are unmarked items' do
			let(:item1) { item.create(list_id: list1.id, text: 'item1', done: false, position: 0) }
			let(:exposures) { Hash[lists: [list1, list2], this_user: this_user, items: { "#{ list1.id }": [item1], "#{ list2.id }": [] }, subitems: { "#{ item1.id }": [] } , params: {} ] }

			it 'lists item' do
				rendered.must_include 'item1'
			end

			describe 'when there are subitems' do
				let(:subitem1) { subitem.create(item_id: item1.id, text: 'Sugar', done: false, position: 0) }
				let(:subitem2) { subitem.create(item_id: item1.id, text: 'Flour', done: true, position: 1) }
				let(:exposures) { Hash[lists: [list1, list2], this_user: this_user, items: { "#{ list1.id }": [item1], "#{ list2.id }": [] }, subitems: { "#{ item1.id }": [subitem1, subitem2] }, params: {}] }

				it 'displays the unmarked subitems' do
					rendered.must_include 'Sugar'
				end

				it 'displays the marked subitems' do
					rendered.must_include 'Flour'
				end
			end
		end

		describe 'when there are marked items' do
			let(:pie) { item.create(list_id: list2.id, text: 'Pie', done: true, position: 0) }
			let(:crust) { subitem.create(item_id: pie.id, text: 'Crust', done: false, position: 0) }
			let(:filling) { subitem.create(item_id: pie.id, text: 'Filling', done: true, position: 1) }
			let(:exposures) { Hash[lists: [list1, list2], this_user: this_user, items: { "#{ list1.id }": [], "#{ list2.id }": [pie] }, subitems: { "#{ pie.id }": [crust, filling] }, params: {}] }



			it 'displays the marked item' do
				rendered.must_include 'Pie'
			end

			it 'does not display marked or unmarked subitems' do
				rendered.wont_include 'Crust'
				rendered.wont_include 'Filling'
			end
		end
	end
end
