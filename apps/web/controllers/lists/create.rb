module Web::Controllers::Lists
  class Create
    include Web::Action

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
        ListRepository.new.create(params[:list])

        redirect_to '/home/index'
      else
        redirect_to '/home/index'
        self.status = 422
      end
    end
  end
end
