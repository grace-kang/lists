class SubitemRepository < Hanami::Repository
  associations do
    belongs_to :items
  end

	def count_given_item(id)
		subitems
			.where(item_id: id)
			.count
	end

	def last_position_given_item(id)
		subitems
			.where(item_id: id)
			.max(:position)
	end

	def find_with_item(id)
		subitems
			.where(item_id: id)
			.order(:position)
		end
end
