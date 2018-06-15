module Web::Controllers::Lists
  class Create
    include Web::Action

    include Import['repositories.list']

    expose :user
    expose :list

    params do
      required(:new_list).schema do
        required(:user_id).filled(:int?)
        required(:name).filled(:str?)
        required(:done).filled(:bool?)
      end
    end

    def call(params)
			if list.count > 0
				pos = list.get_last_position.position + 1
			else
				pos = 0
			end

			params[:new_list][:position] = pos

      list.create(params[:new_list]) if params.valid?
      redirect_to '/home/index'
    end
  end
end
