class ListRepository < Hanami::Repository
  associations do
    has_many :items
  end

	def count
		lists.count
	end

	def order_by_position
		lists
			.order { position.asc }
	end

  def find_items(id)
    aggregate(:items)
			.where(id: id)
			.as(List)
			.one
  end

	def get_last_position
		lists.max(:position)
	end
end
