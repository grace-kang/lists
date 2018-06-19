module Web::Controllers::Subitem
  class Create
    include Web::Action
    include Import['repositories.subitem']

    params do
      required(:newsubitem).schema do
        required(:text).filled(:str?)
        required(:item_id).filled(:int?)
        required(:done).filled(:bool?)
      end
    end

    def call(params)
      if params.valid?
				item_id = params[:newsubitem][:item_id]
				last_pos = 0
				last_pos = subitem.last_position_given_item(item_id) + 1 if subitem.count_given_item(item_id) > 0
				params[:newsubitem][:position] = last_pos

        subitem.create(params[:newsubitem])

        redirect_to '/home/index'
      else
        redirect_to '/home/index'
        self.status = 422
      end
    end
  end
end
