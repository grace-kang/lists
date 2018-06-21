require_relative '../../spec_helper'

describe Mailers::ForgotPass do
  it 'delivers email' do
    mail = Mailers::ForgotPass.deliver
  end
end
