module Web::Controllers::Lists
  class Delete
    include Web::Action

    def call(params)
      ListRepository.new.delete(params[:list_id])

      redirect_to '/'
    end
  end
end
