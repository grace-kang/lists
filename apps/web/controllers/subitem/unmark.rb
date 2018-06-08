module Web::Controllers::Subitem
  class Unmark
    include Web::Action
    include Import['repositories.subitem']

    def call(params)
			subitem_id = params[:unmark_subitem][:id]
			subitem.update(subitem_id, done: false)
			redirect_to '/home/index'
    end
  end
end
