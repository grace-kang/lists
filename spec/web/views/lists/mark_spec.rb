require_relative '../../../spec_helper'

describe Web::Views::Lists::Mark do
  let(:exposures) { Hash[format: :html] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/lists/mark.html.erb') }
  let(:view)      { Web::Views::Lists::Mark.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #format' do
    view.format.must_equal exposures.fetch(:format)
  end
end
