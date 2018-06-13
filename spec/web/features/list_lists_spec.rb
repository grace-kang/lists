require 'features_helper'

describe 'List lists' do
  include Import['repositories.user']
  include Import['repositories.list']
  include Import['repositories.item']
  include Import['repositories.subitem']

  before do
    user.clear
    list.clear
    item.clear
    subitem.clear

    @user = user.create(email: 'email', hashed_pass: hashed_password('pass'), email_confirmed: true, token: 'token')
    @list1 = list.create(user_id: @user.id, name: 'Groceries', done: false)
    @list2 = list.create(user_id: @user.id, name: 'To Do', done: false)

    visit '/'
    click_button 'Log In'
    current_path.must_equal '/sessions/new'

    within 'form#session-form' do
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: 'pass'
      click_button 'Log In'
    end
  end

  it 'displays each list on the page' do
    current_path.must_equal '/home/index'

    page.html.must_include 'Groceries'
    page.html.must_include 'To Do'
  end

  describe 'when there are items' do
    before do
      @item1 = item.create(list_id: @list1.id, text: 'Mushrooms', done: false)
      @item2 = item.create(list_id: @list2.id, text: 'Laundry', done: false)
      visit '/home/index'
    end

    it 'displays the items' do
      page.html.must_include 'Mushrooms'
      page.html.must_include 'To Do'
    end

    describe 'when there are subitems' do
      before do
        subitem.create(item_id: @item1.id, text: 'Crimini', done: false)
        subitem.create(item_id: @item2.id, text: 'Bed Sheets', done: false)
        visit '/home/index'
      end

      it 'displays the subitems' do
        page.html.must_include 'Crimini'
        page.html.must_include 'Bed Sheets'
      end
    end
  end
end
