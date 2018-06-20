class ItemRepository < Hanami::Repository
  associations do
    belongs_to :lists
    has_many :subitems
  end

	def count_given_list(id)
		items
			.where(list_id: id)
			.count
	end

	def last_position_given_list(id)
		items
			.where(list_id: id)
			.max(:position)
	end

  def find_by_list(id)
		items	
			.where(list_id: id)
			.order(:position)
			.to_a
  end
	
	def find_subitems(id)
		aggregate(:subitems)
			.order(:position)
			.where(id: id)
			.as(Item)
			.one
	end
end
