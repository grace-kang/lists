module Web::Controllers::Lists
  class Delete
    include Web::Action

    def call(params)
      puts params[:list]
      ListRepository.new.delete(params[:list][:id])

      redirect_to '/'
    end
  end
end
