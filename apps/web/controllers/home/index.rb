module Web::Controllers::Home
  class Index
    include Web::Action

    expose :lists

    def call(params)
      repository = ListRepository.new
      @lists = repository.all
      @lists.map! { |list| list = repository.find_items(list.id) }
    end
  end
end