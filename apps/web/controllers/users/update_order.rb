module Web::Controllers::Users
  class UpdateOrder
    include Web::Action
		include Import['repositories.list']

    def call(params)
			order = JSON.parse(params[:order])
			puts order
			order.each { |key, value| list.update(key, position: value) }
			puts list.find(1)
			
			redirect_to '/home/index'
    end
  end
end
