class ListRepository < Hanami::Repository
  associations do
    has_many :items
  end

	def count
		lists.count
	end

	def find_with_user_id(id)
		lists
			.where(user_id: id)
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
