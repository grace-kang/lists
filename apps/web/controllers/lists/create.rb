module Web::Controllers::Lists
  class Create
    include Web::Action

    def call(params)
      ListRepository.new.create(params[:list])

      redirect_to '/'
    end
  end
end
