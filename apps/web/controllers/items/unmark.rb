module Web::Controllers::Items
  class Unmark
    include Web::Action
    include Import['repositories.item']

    def call(params)
      item_id = params[:unmark_item][:id]
      item.update(item_id, done: false)
      redirect_to '/home/index'
    end
  end
end
