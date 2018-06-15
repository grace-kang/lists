require_relative '../../../spec_helper'

describe Web::Views::Users::UpdateOrder do
  let(:exposures) { Hash[format: :html] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/users/update_order.html.erb') }
  let(:view)      { Web::Views::Users::UpdateOrder.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #format' do
    view.format.must_equal exposures.fetch(:format)
  end
end
