require 'dry/system/container'
require_relative 'resolver'

class Application < Dry::System::Container
  extend Dry::Hanami::Resolver

  register_folder! 'lists/repositories'

  configure
end


