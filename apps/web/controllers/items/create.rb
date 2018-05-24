module Web::Controllers::Items
  class Create
    include Web::Action

    def call(params)
      ItemRepository.new.create(params[:item])

      redirect_to '/'
    end
  end
end