module API::Serializers
	class Item < Hanami::Serializer::Base
		attribute :id, Types::Int
		attribute :list_id, Types::Int
		attribute :text, Types::String
		attribute :done, Types::Bool
		attribute :position, Types::Int
	end
end
