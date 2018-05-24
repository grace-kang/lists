class ListRepository < Hanami::Repository
	associations do
		has_many :items
	end

	def find_items(id)
		aggregate(:items).where(id: id).as(List).one
	end

	def add_item(name, data)
		assoc(:items, name).add(data)
	end

	def remove_item(list_id, item_id)
		assoc(:items, list_id).remove(item_id)
	end
end
