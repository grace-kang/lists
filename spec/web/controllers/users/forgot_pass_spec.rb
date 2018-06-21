require_relative '../../../spec_helper'

describe Web::Controllers::Users::ForgotPass do
  let(:action) { Web::Controllers::Users::ForgotPass.new }
  let(:params) { Hash[] }

  it 'is successful' do
    response = action.call(params)
    response[0].must_equal 200
  end
end
