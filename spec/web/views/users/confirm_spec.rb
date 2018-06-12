require_relative '../../../spec_helper'

describe Web::Views::User::Confirm do
  let(:exposures) { Hash[format: :html] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/user/confirm.html.erb') }
  let(:view)      { Web::Views::User::Confirm.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #format' do
    view.format.must_equal exposures.fetch(:format)
  end
end
