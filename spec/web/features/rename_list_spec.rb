require 'features_helper'

describe 'Rename a list' do
  include Import['repositories.user']
  include Import['repositories.list']

  before do
    user.clear
    list.clear

    @user = user.create(email: 'email', hashed_pass: hashed_password('pass'), email_confirmed: true, token: 'token')
    @groceries = list.create(user_id: @user.id, name: 'Groceries')

    visit '/'
    click_button 'Log In'
    within 'form#session-form' do
      fill_in 'Email', with: 'email'
      fill_in 'Password', with: 'pass'
      click_button 'Log In'
    end
  end

  it 'can rename an existing list' do
    current_path.must_equal '/home/index'
    page.html.must_include 'Groceries'
    click_button 'Groceries'
    
    Capybara.ignore_hidden_elements = false
    within 'form#rename_list-form' do
      fill_in 'New Name', with: 'Chores'
      click_button ''
    end
    Capybara.ignore_hidden_elements = true

    page.html.wont_include 'Groceries'
    page.html.must_include 'Chores'
  end
end
