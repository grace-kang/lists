module API::Serializers
	class List < Hanami::Serializer::Base
		attribute :id, Types::Int
	  attribute :user_id, Types::Int
		attribute :name, Types::String	
		attribute :done, Types::Bool
		attribute :position, Types::Int
	end
end
