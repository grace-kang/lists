module Web::Controllers::Subitem
  class Mark
    include Web::Action
    include Import['repositories.subitem']

    def call(params)
			subitem_id = params[:subitem][:id]
			subitem.update(subitem_id, done: true) 
			redirect_to '/home/index'
    end
  end
end
