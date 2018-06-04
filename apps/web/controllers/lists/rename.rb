module Web::Controllers::Lists
  class Rename
    include Web::Action
    include Import['repositories.list']

    def call(params)
      list_id = params[:list][:id]
      list.update(list_id, name: params[:list][:name])
      redirect_to '/home/index'
    end
  end
end
