require_relative '../../../spec_helper'

describe Web::Controllers::Items::Create do
  let(:action) { Web::Controllers::Items::Create.new }
  let(:list) { ListRepository.new.create(name: 'list1') }
  let(:params) { Hash[item: { list_id: list.id, text: 'mushrooms' }] }
  let(:repository) { ItemRepository.new }

  before do
    repository.clear
  end

  it 'creates a new item' do
    action.call(params)
    item = repository.last

    item.id.wont_be_nil
    item.text.must_equal params.dig(:item, :text)
  end

  it 'redirects the user to the home page' do
    response = action.call(params)

    response[0].must_equal 302
    response[1]['Location'].must_equal '/'
  end
end