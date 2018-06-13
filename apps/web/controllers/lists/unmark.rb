module Web::Controllers::Lists
  class Unmark
    include Web::Action
    include Import['repositories.list']

    def call(params)
      list.update(params[:unmark_list][:id], done: false)
      redirect_to '/home/index'
    end
  end
end
