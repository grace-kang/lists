module Web::Controllers::Lists
  class Rename
    include Web::Action
    include Import['repositories.list']

    def call(params)
      list_id = params[:rename_list][:id]
      list.update(list_id, name: params[:rename_list][:name])
      redirect_to '/home/index'
    end
  end
end
