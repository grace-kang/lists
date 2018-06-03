class SubitemRepository < Hanami::Repository
  associations do
    belongs_to :items
  end
end
