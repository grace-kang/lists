require 'features_helper'

describe 'Unmark a marked subitem' do
  include Import['repositories.user']
  include Import['repositories.list']
  include Import['repositories.item']
  include Import['repositories.subitem']

  before do
    user.clear
    list.clear
    item.clear
    subitem.clear

    @user = user.create(email: 'email', hashed_pass: hashed_password('pass'))
    @list = list.create(user_id: @user.id, name: 'Groceries')
    @item = item.create(list_id: @list.id, text: 'Cake', done: false)
    subitem.create(item_id: @item.id, text: 'Flour', done: true)

    visit '/'
    click_button 'Log In'
    within 'form#session-form' do
      fill_in 'Email', with: 'email'
      fill_in 'Password', with: 'pass'
      click_button 'Log In'
    end
  end

  it 'marks the unmarked subitem' do
    current_path.must_equal '/home/index'
    page.html.must_include 'class="text-grey mx-3 line-through overflow-auto px-6">Flour'
    within 'form#unmark_subitem-form' do
      click_button 'Flour'
    end

    page.html.wont_include 'class="text-grey mx-3 line-through overflow-auto px-6">Flour'
    page.html.must_include 'class="text-grey-darker mx-3 overflow-auto px-6">Flour'
  end
end