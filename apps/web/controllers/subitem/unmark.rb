module Web::Controllers::Subitem
  class Unmark
    include Web::Action

    def call(params)
      repository = SubitemRepository.new
			subitem_id = params[:subitem][:id]
			repository.update(subitem_id, done: false)
			redirect_to '/home/index'
    end
  end
end
