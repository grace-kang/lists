module Web::Controllers::Items
  class UpdateOrder
    include Web::Action
		include Import['repositories.subitem']

    def call(params)
			order = JSON.parse(params[:order])
			order.each { |key, value| subitem.update(key, position: value) }

			redirect_to '/home/index'
    end
  end
end
