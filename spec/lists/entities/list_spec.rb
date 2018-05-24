require_relative '../../spec_helper'

describe List do
  it 'can be initialized with a name' do
    list = List.new(name: 'Groceries')
    list.name.must_equal 'Groceries'
  end
end
