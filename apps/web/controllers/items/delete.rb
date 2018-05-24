module Web::Controllers::Items
  class Delete
    include Web::Action

    def call(params)
      ItemRepository.new.delete(params[:item])

      redirect_to '/'
    end
  end
end
