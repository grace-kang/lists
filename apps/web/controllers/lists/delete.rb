module Web::Controllers::Lists
  class Delete
    include Web::Action
    include Import['repositories.list']

    def call(params)
      list.delete(params[:list][:id])

      redirect_to '/home/index'
    end
  end
end
