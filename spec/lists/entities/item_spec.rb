require_relative '../../spec_helper'

describe Item do
  it 'can be initialized with text' do
    item = Item.new(text: 'Mushroom')
    item.text.must_equal 'Mushroom'
  end
end
