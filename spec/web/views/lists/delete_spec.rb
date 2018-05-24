require_relative '../../../spec_helper'

describe Web::Views::Lists::Delete do
  let(:exposures) { Hash[format: :html] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/lists/delete.html.erb') }
  let(:view)      { Web::Views::Lists::Delete.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #format' do
    view.format.must_equal exposures.fetch(:format)
  end
end
