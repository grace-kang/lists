class ItemRepository < Hanami::Repository
	associations do
		belongs_to :lists
	end
end	
