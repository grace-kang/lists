module Web::Controllers::Lists
  class UpdateOrder
    include Web::Action
		include Import['repositories.item']

    def call(params)
			order = JSON.parse(params[:order])
			order.each { |key, value| item.update(key, position: value) }

			redirect_to '/home/index'
    end
  end
end
