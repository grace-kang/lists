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
			last_pos = list.get_last_position
			puts last_pos
			puts last_pos.position
			params[:new_list][:position] = last_pos + 1

      list.create(params[:new_list]) if params.valid?
      redirect_to '/home/index'
    end
  end
end
