module Web::Controllers::Subitem
  class Delete
    include Web::Action

    def call(params)
      SubitemRepository.new.delete(params[:subitem][:id])
      redirect_to '/home/index'
    end
  end
end
