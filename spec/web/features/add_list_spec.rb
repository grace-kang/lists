require 'features_helper'

describe 'Add a list' do
  after do
    ListRepository.new.clear
  end

  it 'can create a new list' do
    visit '/'

    within 'form#list_form' do
      fill_in 'Name', with: 'Some name'
      click_button 'Create List'
    end

    current_path.must_equal('/')
    assert page.has_content?('Some name')
  end
end