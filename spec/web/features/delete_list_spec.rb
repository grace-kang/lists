require 'features_helper'

describe 'Delete a list' do
  include Import['repositories.user']
  include Import['repositories.list']

  before do
    user.clear
    list.clear

    @user = user.create(email: 'email', hashed_pass: hashed_password('pass'), email_confirmed: true, token: 'token')
    @list = list.create(user_id: @user.id, name: 'Groceries')

    visit '/'
    click_button 'Log In'

    within 'form#session-form' do
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: 'pass'
      click_button 'Log In'
    end
  end

  it 'can delete an existing list' do
    current_path.must_equal '/home/index'
    page.html.must_include 'Groceries'
    within 'form#delete_list-form' do
      click_button 'X'
    end

    page.html.wont_include 'Groceries'
  end
end