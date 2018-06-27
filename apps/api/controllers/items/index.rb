module API::Controllers::Items
	class Index
		include API::Action
		include Hanami::Serializer::Action
		include Import['repositories.item']

		def call(params)
			items = item.find_by_list(params[:id])

			hash = []
			items.each { |item| hash.push(serializer.new(item)) }

			send_json(hash)
		end
	end
end
