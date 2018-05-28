module Web::Controllers::Items
  class Create
    include Web::Action

    expose :item

    params do
      required(:item).schema do
        required(:text).filled(:str?)
        required(:list_id).filled(:int?)
      end
    end

    def call(params)
      if params.valid?
        ItemRepository.new.create(params[:item])

        redirect_to '/'
      else
        redirect_to '/'
        self.status = 422
      end
    end
  end
end