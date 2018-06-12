require 'features_helper'

describe 'Add a user' do
  include Import['repositories.user']

  before do
    user.clear
  end

  it 'creates a user' do
    visit '/'

    click_button 'Sign Up'

    current_path.must_equal '/users/new'

    within 'form#user-form' do
      fill_in 'Email', with: 'email'
      fill_in 'Password', with: 'pass'
      fill_in 'Confirm Password', with: 'pass'
      click_button 'Sign Up'
    end
    
    current_path.must_equal '/'
    page.html.must_include 'Successfully signed up!'
  end
end

