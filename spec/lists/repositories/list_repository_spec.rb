require_relative '../../spec_helper'

describe ListRepository do
  it 'can find all items associated to a list_id' do
    list1 = ListRepository.new.create(name: 'Groceries')
    item1 = ItemRepository.new.create(list_id: list1.id, text: 'Mushrooms')
    list1 = ListRepository.new.find_items(list1.id)
    list1.items.last.text.must_equal 'Mushrooms'
  end
end
