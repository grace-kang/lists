require_relative '../../../spec_helper'

describe Web::Controllers::Sessions::Destroy do
  let(:action) { Web::Controllers::Sessions::Destroy.new }
  let(:params) { Hash[] }

  it 'redirects to root' do
    response = action.call(params)
    response[0].must_equal 302
    response[1]['Location'].must_equal '/'
  end
end
