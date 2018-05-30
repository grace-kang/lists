require_relative '../../../spec_helper'

describe Web::Views::Items::Unmark do
  let(:exposures) { Hash[format: :html] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/items/unmark.html.erb') }
  let(:view)      { Web::Views::Items::Unmark.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #format' do
    view.format.must_equal exposures.fetch(:format)
  end
end
