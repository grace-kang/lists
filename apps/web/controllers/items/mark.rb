module Web::Controllers::Items
  class Mark
    include Web::Action
    include Import['repositories.item']

    def call(params)
			item_id = params[:mark_item][:id]
			item.update(item_id, done: true) 
			redirect_to '/home/index'
    end
  end
end
