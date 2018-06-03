module Web::Controllers::Items
  class Delete
    include Web::Action

    def call(params)
      ItemRepository.new.delete(params[:item][:id])

      redirect_to '/home/index'
    end
  end
end
