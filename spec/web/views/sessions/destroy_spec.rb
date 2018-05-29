require_relative '../../../spec_helper'

describe Web::Views::Sessions::Destroy do
  let(:exposures) { Hash[format: :html] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/sessions/destroy.html.erb') }
  let(:view)      { Web::Views::Sessions::Destroy.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #format' do
    view.format.must_equal exposures.fetch(:format)
  end
end
