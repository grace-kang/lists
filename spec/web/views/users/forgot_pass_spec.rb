require_relative '../../../spec_helper'

describe Web::Views::Users::ForgotPass do
  let(:exposures) { Hash[format: :html] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/users/forgot_pass.html.erb') }
  let(:view)      { Web::Views::Users::ForgotPass.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #format' do
    view.format.must_equal exposures.fetch(:format)
  end
end
