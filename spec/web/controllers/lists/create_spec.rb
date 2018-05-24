require_relative '../../../spec_helper'

describe Web::Controllers::Lists::Create do
  let(:action) { Web::Controllers::Lists::Create.new }
  let(:params) { Hash[list: { name: 'Groceries' }] }
  let(:repository) { ListRepository.new }

  before do
    repository.clear
  end

  it 'creates a new list' do
    action.call(params)
    list = repository.last

    list.id.wont_be_nil
    list.name.must_equal params.dig(:list, :name)
  end

  it 'redirects the user to the home page' do
    response = action.call(params)

    response[0].must_equal 302
    response[1]['Location'].must_equal '/'
  end
end
