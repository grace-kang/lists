require_relative '../../../spec_helper'

describe Web::Controllers::Items::Unmark do
  let(:action) { Web::Controllers::Items::Unmark.new }
  let(:params) { Hash[] }

  it 'is successful' do
    response = action.call(params)
    response[0].must_equal 200
  end
end
