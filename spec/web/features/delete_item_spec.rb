require 'features_helper'

describe 'Delete an item' do
  include Import['repositories.user']
  include Import['repositories.list']
  include Import['repositories.item']

  before do
    user.clear
    list.clear
    item.clear

    @user = user.create(email: 'email', hashed_pass: hashed_password('pass'), email_confirmed: true, token: 'token')
    @list = list.create(user_id: @user.id, name: 'Groceries', done: false, position: 0)
    @mushrooms = item.create(list_id: @list.id, text: 'Mushrooms', done: false)
  end

  it 'deletes an existing item' do
    visit '/'
    click_button 'Log In'
    current_path.must_equal '/sessions/new'

    within 'form#session-form' do
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: 'pass'
      click_button 'Log In'
    end

    current_path.must_equal '/home/index'
    page.html.must_include 'Mushrooms'
    within 'form#delete_item-form' do
      click_button 'x'
    end

    page.html.wont_include 'Mushrooms'
  end
end
