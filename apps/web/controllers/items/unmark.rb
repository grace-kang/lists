module Web::Controllers::Items
  class Unmark
    include Web::Action

    def call(params)
			repository = ItemRepository.new
			item_id = params[:item][:id]
			repository.update(item_id, done: false)
			redirect_to '/home/index'
    end
  end
end
