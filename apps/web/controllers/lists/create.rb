module Web::Controllers::Lists
  class Create
    include Web::Action

    expose :list

    params do
      required(:list).schema do
        required(:name).filled(:str?)
      end
    end

    def call(params)
      if params.valid?
        ListRepository.new.create(params[:list])

        redirect_to '/'
      else
        redirect_to '/'
        self.status = 422
      end
    end
  end
end
