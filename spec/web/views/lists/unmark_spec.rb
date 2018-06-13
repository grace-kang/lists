require_relative '../../../spec_helper'

describe Web::Views::Lists::Unmark do
  let(:exposures) { Hash[format: :html] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/lists/unmark.html.erb') }
  let(:view)      { Web::Views::Lists::Unmark.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #format' do
    view.format.must_equal exposures.fetch(:format)
  end
end
