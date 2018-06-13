module Web::Controllers::Items
  class Create
    include Web::Action
    include Import['repositories.item']

    params do
      required(:newitem).schema do
        required(:text).filled(:str?)
        required(:list_id).filled(:int?)
        required(:done).filled(:bool?)
      end
    end

    def call(params)
      if params.valid?
        item.create(params[:newitem])

        redirect_to '/home/index'
      else
        redirect_to '/home/index'
        self.status = 422
      end
    end
  end
end
