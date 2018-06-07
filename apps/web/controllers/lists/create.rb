module Web::Controllers::Lists
  class Create
    include Web::Action

    include Import['repositories.list']

    expose :user
    expose :list

    params do
      required(:list).schema do
        required(:user_id).filled(:int?)
        required(:name).filled(:str?)
      end
    end

    def call(params)
      if params.valid?
        list.create(params[:list])

        redirect_to '/home/index'
      else
        redirect_to '/home/index'
      end
    end
  end
end
