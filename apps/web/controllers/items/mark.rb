module Web::Controllers::Items
  class Mark
    include Web::Action

    def call(params)
			repository = ItemRepository.new
			item_id = params[:item][:id]
			repository.update(item_id, done: true) 
			redirect_to '/home/index'
    end
  end
end
