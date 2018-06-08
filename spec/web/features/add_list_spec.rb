require 'features_helper'

describe 'Add a list' do
  include Import['repositories.user']
  include Import['repositories.list']

  before do
    user.clear
    list.clear

    @user = user.create(email: 'email', hashed_pass: hashed_password('pass'))
  end

  it 'can create a new list' do
    visit '/'

    click_button 'Log In'

    current_path.must_equal('/sessions/new')

    within 'form#session-form' do
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: 'pass'
      click_button 'Log In'
    end

    current_path.must_equal('/home/index')

    within 'form#new_list-form' do
      fill_in 'List Name', with: 'Some name'
      click_button 'Create'
    end

    current_path.must_equal('/home/index')
    assert page.has_content?('Some name')
  end
end

