require_relative '../../../spec_helper'

describe Web::Views::Items::Mark do
  let(:exposures) { Hash[format: :html] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/items/mark.html.erb') }
  let(:view)      { Web::Views::Items::Mark.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #format' do
    view.format.must_equal exposures.fetch(:format)
  end
end
