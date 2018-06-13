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
        list.create(params[:new_list])

        redirect_to '/home/index'
      else
        redirect_to '/home/index'
      end
    end
  end
end
