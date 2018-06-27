module API::Controllers::Lists
  class Index
    include API::Action
		include Hanami::Serializer::Action
		include ['repositories.list']

    def call(params)
			lists = list.find_with_user_id(params[:id])
			lists = serializer.new(lists)
			send_json(lists)
    end
  end
end
