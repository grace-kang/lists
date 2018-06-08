module Web::Controllers::Items
  class Delete
    include Web::Action
    include Import['repositories.item']

    def call(params)
      item.delete(params[:delete_item][:id])

      redirect_to '/home/index'
    end
  end
end
