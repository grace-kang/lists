require 'features_helper'

describe 'Add an item' do
  include Import['repositories.user']
  include Import['repositories.list']
  include Import['repositories.item']

  before do
    user.clear
    list.clear
    item.clear

    @user = user.create(email: 'email', hashed_pass: hashed_password('pass'), email_confirmed: true, token: 'token')
    @list = list.create(user_id: @user.id, name: 'Groceries', done: false, position: 0)
  end

  it 'can create a new item' do
    visit '/'

    click_button 'Log In'

    current_path.must_equal('/sessions/new')
    within 'form#session-form' do
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: 'pass'
      click_button 'Log In'
    end
    within 'form#newitem-form' do
      fill_in 'New Item', with: 'Some text'
      click_button 'Add'
    end

    current_path.must_equal('/home/index')
    assert page.has_content?('Some text')
  end
end
