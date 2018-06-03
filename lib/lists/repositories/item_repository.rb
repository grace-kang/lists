class ItemRepository < Hanami::Repository
  associations do
    belongs_to :lists
    has_many :subitems
  end

  def find_subitems(id)
    aggregate(:subitems).where(id: id).as(Item).one
  end
end
