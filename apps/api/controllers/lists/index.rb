module API::Controllers::Lists
  class Index
    include API::Action
		include Hanami::Serializer::Action
		include Import['repositories.list']

    def call(params)
			lists = list.find_with_user_id(params[:id])
			
			hash = []
			lists.each { |list| hash.push(serializer.new(list)) }
			send_json(hash)
    end
  end
end
