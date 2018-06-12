require 'features_helper'

describe 'Destroy a session' do
  include Import['repositories.user']

  before do
    user.clear
    user.create(email: 'email', hashed_pass: hashed_password('pass'), email_confirmed: true, token: 'token')
    visit '/'
    click_button 'Log In'
    within 'form#session-form' do
      fill_in 'Email', with: 'email'
      fill_in 'Password', with: 'pass'
      click_button 'Log In'
    end
  end

  it 'logs out a user' do
    current_path.must_equal '/home/index'
    click_button 'Log Out'

    current_path.must_equal '/'

    visit '/home/index'
    current_path.must_equal '/'
  end
end