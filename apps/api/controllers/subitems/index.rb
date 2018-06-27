module API::Controllers::Subitems
	class Index
		include API::Action
		include Hanami::Serializer::Action
		include Import['repositories.subitem']

		def call(params)
			subitems = subitem.find_with_item(params[:id])

			hash = []
			subitems.each { |subitem| hash.push(serializer.new(subitem)) }
			send_json(hash)
		end
	end
end
