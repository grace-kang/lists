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

  let(:current_user) { user.create(email: 'email', hashed_pass: hashed_password('pass'))}
  let(:exposures) { Hash[lists: [], this_user: current_user, params: {}] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/home/index.html.erb') }
  let(:view)      { Web::Views::Home::Index.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #lists' do
    view.lists.must_equal exposures.fetch(:lists)
  end

  it 'exposes #this_user' do
    view.this_user.must_equal exposures.fetch(:this_user)
  end

  describe 'when there are no lists' do
    it 'shows a placeholder message' do
      rendered.must_include('You do not have any lists yet.')
    end
  end

  describe 'when there are lists' do
    let(:list1)     { list.create(user_id: current_user.id, name: 'Groceries') }
    let(:list2)     { list.create(user_id: current_user.id, name: 'Homework') }
    let(:exposures) { Hash[lists: [list1, list2], this_user: current_user, params: {}] }

    before do
      exposures[:lists].map! { |l| list.find_items(l.id) }
      exposures[:lists].each { |l| l.items.map! { |i| item.find_subitems(i.id) } }
    end

    it 'lists them all' do
      rendered.must_include('Groceries')
      rendered.must_include('Homework')
    end

    it 'hides the placeholder message' do
      rendered.wont_include('You do not have any lists yet.')
    end

    describe 'when there are unmarked items' do

      before do
        item.create(list_id: list1.id, text: 'Mushrooms', done: false)
        exposures[:lists].map! { |l| list.find_items(l.id) }
        exposures[:lists].each { |l| l.items.map! { |i| item.find_subitems(i.id) } }
      end

      it 'lists item' do
        rendered.scan(/id="items"/).count.must_equal 1
        rendered.must_include 'Mushrooms'
      end

      describe 'when there are subitems' do

        before do
          cake = item.create(list_id: list1.id, text: 'Cake Ingredients', done: false)
          subitem.create(item_id: cake.id, text: 'Sugar', done: false)
          subitem.create(item_id: cake.id, text: 'Flour', done: true)
          exposures[:lists].map! { |l| list.find_items(l.id) }
          exposures[:lists].each { |l| l.items.map! { |i| item.find_subitems(i.id) } }
        end

        it 'displays the unmarked subitems' do
          rendered.must_include 'Sugar'
        end

        it 'displays the marked subitems' do
          rendered.must_include 'Flour'
        end
      end
    end 

    describe 'when there are marked items' do
      before do
        pie = item.create(list_id: list1.id, text: 'Pie', done: true)
        subitem.create(item_id: pie.id, text: 'Crust', done: false)
        subitem.create(item_id: pie.id, text: 'Filling', done: true)
        exposures[:lists].map! { |l| list.find_items(l.id) }
        exposures[:lists].each { |l| l.items.map! { |i| item.find_subitems(i.id) } }
      end

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

