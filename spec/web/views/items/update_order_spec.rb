require_relative '../../../spec_helper'

describe Web::Views::Items::UpdateOrder do
  let(:exposures) { Hash[format: :html] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/items/update_order.html.erb') }
  let(:view)      { Web::Views::Items::UpdateOrder.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #format' do
    view.format.must_equal exposures.fetch(:format)
  end
end
