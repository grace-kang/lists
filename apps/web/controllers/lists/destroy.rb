module Web::Controllers::Lists
  class Destroy
    include Web::Action
    include Import['repositories.list']

    def call(params)
      list.delete(params[:delete_list][:id])

      redirect_to '/home/index'
    end
  end
end
