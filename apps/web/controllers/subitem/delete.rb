module Web::Controllers::Subitem
  class Delete
    include Web::Action
    include Import['repositories.subitem']

    def call(params)
      subitem.delete(params[:delete_subitem][:id])
      redirect_to '/home/index'
    end
  end
end
