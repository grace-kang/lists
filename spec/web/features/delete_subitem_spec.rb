require 'features_helper'

describe 'Delete a subitem' do
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
    subitem.create(item_id: @item.id, text: 'Sugar', done: false)

    visit '/'
    click_button 'Log In'
    within 'form#session-form' do
      fill_in 'Email', with: 'email'
      fill_in 'Password', with: 'pass'
      click_button 'Log In'
    end
  end

  it 'deletes the specified subitem' do
    current_path.must_equal '/home/index'
    page.html.must_include 'Sugar'
    within 'form#delete_subitem-form' do
      click_button 'x'
    end

    page.html.wont_include 'Sugar'
  end
end


