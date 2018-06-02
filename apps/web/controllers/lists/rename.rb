module Web::Controllers::Lists
  class Rename
    include Web::Action

    def call(params)
      repository = ListRepository.new
      list_id = params[:list][:id]
      repository.update(list_id, name: params[:list][:name])
      redirect_to '/home/index'
    end
  end
end
