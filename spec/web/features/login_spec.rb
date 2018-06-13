require 'features_helper'

describe 'Create a new session' do
  include Import['repositories.user']

  before do
    user.clear
    user.create(email: 'email', hashed_pass: hashed_password('pass'), email_confirmed: true, token: 'token')
  end

  it 'can log in a user' do
    visit '/'
    click_button 'Log In'
    current_path.must_equal '/sessions/new'

    within 'form#session-form' do
      fill_in 'Email', with: 'email'
      fill_in 'Password', with: 'pass'
      click_button 'Log In'
    end

    current_path.must_equal '/home/index'
  end
end
