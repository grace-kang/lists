module API::Serializers
	class Subitem < Hanami::Serializer::Base
		attribute :id, Types::Int
		attribute :item_id, Types::Int
		attribute :text, Types::String
		attribute :done, Types::Bool
		attribute :position, Types::Int
	end
end
