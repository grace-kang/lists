require 'features_helper'

describe 'List lists' do
  let(:lists) { ListRepository.new }
  before do
    lists.clear

    lists.create(name: 'Groceries')
    lists.create(name: 'Homework')
  end

  it 'displays each list on the page' do
    visit '/'

    within '#lists' do
      assert page.has_css?('.list', count: 2), 'Expected to find 2 lists'
    end
  end
end