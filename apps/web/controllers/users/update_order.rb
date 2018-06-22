module Web::Controllers::Users
  class UpdateOrder
    include Web::Action
		include Import['repositories.list']

    def call(params)
			order = JSON.parse(params[:order])
			order.each { |key, value| list.update(key, position: value) }
			
			redirect_to '/home/index'
    end
  end
end
