module Web::Controllers::Items
  class Delete
    include Web::Action

    def call(params)
      puts params[:item]
      ItemRepository.new.delete(params[:item][:id])

      redirect_to '/'
    end
  end
end
