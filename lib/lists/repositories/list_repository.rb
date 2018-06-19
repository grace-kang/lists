class ListRepository < Hanami::Repository
  associations do
    has_many :items
		belongs_to :lists
  end

	def count_given_user(id)
		lists
			.where(user_id: id)
			.count
	end

	def find_with_user_id(id)
		lists
			.where(user_id: id)
			.order { position.asc }
			.to_a
	end

  def find_items(id)
    aggregate(:items)
			.order(:position)
			.where(id: id)
			.as(List)
			.one
  end

	def last_position_given_user(id)
		lists
			.where(user_id: id)
			.max(:position)
	end
end
