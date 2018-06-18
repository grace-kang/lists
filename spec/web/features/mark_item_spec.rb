require 'features_helper'

describe 'Mark an unmarked item' do
  include Import['repositories.user']
  include Import['repositories.list']
  include Import['repositories.item']

  before do
    user.clear
    list.clear
    item.clear

    @user = user.create(email: 'email', hashed_pass: hashed_password('pass'), email_confirmed: true, token: 'token')
    @list = list.create(user_id: @user.id, name: 'Groceries', done: false, position: 0)
    item.create(list_id: @list.id, text: 'Pepper', done: false)

    visit '/'
    click_button 'Log In'
    within 'form#session-form' do
      fill_in 'Email', with: 'email'
      fill_in 'Password', with: 'pass'
      click_button 'Log In'
    end
  end

  it 'marks the unmarked item' do
    current_path.must_equal '/home/index'
    page.html.must_include 'class="text-grey-darker ml-3 overflow-auto">Pepper'
    within 'form#mark_item-form' do
      click_button 'Pepper'
    end

    page.html.wont_include 'class="text-grey-darker ml-3 overflow-auto">Pepper'
    page.html.must_include 'class="text-grey ml-3 line-through overflow-auto">Pepper'
  end
end
