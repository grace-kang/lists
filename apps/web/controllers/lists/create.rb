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
			if params.valid?
				last_pos = 0
				user_id = params[:new_list][:user_id]
				last_pos = list.last_position_given_user(user_id) + 1 if list.count_given_user(user_id) > 0

				params[:new_list][:position] = last_pos
      	list.create(params[:new_list])
			end

      redirect_to '/home/index'
    end
  end
end
