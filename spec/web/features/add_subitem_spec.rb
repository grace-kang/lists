require 'features_helper'

describe 'Add a subitem' do
  include Import['repositories.user']
  include Import['repositories.list']
  include Import['repositories.item']
  include Import['repositories.subitem']

  before do
    user.clear
    list.clear
    item.clear
    subitem.clear

    @user = user.create(email: 'email', hashed_pass: hashed_password('pass'), email_confirmed: true, token: 'token')
    @list = list.create(user_id: @user.id, name: 'Groceries', done: false, position: 0)
    @item = item.create(list_id: @list.id, text: 'Cake', done: false)
  end

  it 'can create a new subitem' do
    visit '/'

    click_button 'Log In'

    current_path.must_equal('/sessions/new')

    within 'form#session-form' do
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: 'pass'
      click_button 'Log In'
    end

    current_path.must_equal('/home/index')

    click_button '+'

    Capybara.ignore_hidden_elements = false
    within 'form#newsubitem-form' do
      fill_in 'New Subitem', with: 'Some text'
      click_button 'Add'
    end
    Capybara.ignore_hidden_elements = true

    current_path.must_equal('/home/index')
    assert page.has_content?('Some text')
  end
end
