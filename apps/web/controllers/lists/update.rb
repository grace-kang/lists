module Web::Controllers::Lists
  class Update
    include Web::Action
    include Import['repositories.list']

    def call(params)
      list_id = params[:update_list][:id]
      list.update(list_id, name: params[:update_list][:name])
      redirect_to '/home/index'
    end
  end
end
