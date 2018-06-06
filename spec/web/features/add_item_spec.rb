require 'features_helper'

describe 'Add an item' do
  let(:list) { ListRepository.new.create(name: 'list') }

  after do
    ItemRepository.new.clear
  end

  it 'can create a new item' do
    visit '/'

    within 'form#item_form' do
      fill_in 'New item', with: 'Some text'
      click_button 'Add'
    end

    current_path.must_equal('/')
    assert page.has_content?('Some text')
  end
end

