class ListRepository < Hanami::Repository
	associations do
		has_many :items
	end

	def find_items(id)
		aggregate(:items).where(id: id).as(List).one
	end
end
