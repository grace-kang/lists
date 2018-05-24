require_relative '../../../spec_helper'

describe Web::Controllers::Home::Index do
  let(:action) { Web::Controllers::Home::Index.new }
  let(:params) { Hash[] }
  let(:lists) { ListRepository.new }

  before do
    lists.clear

    @list = lists.create(name: 'Groceries')
  end

  it 'is successful' do
    response = action.call(params)
    response[0].must_equal 200
  end

  it 'exposes all lists' do
    action.call(params)
    action.exposures[:lists].must_equal [@list]
  end
end