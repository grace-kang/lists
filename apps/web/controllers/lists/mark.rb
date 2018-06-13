module Web::Controllers::Lists
  class Mark
    include Web::Action
    include Import['repositories.list']

    def call(params)
      list.update(params[:mark_list][:id], done: true)
      redirect_to '/home/index'
    end
  end
end
