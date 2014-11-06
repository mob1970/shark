require './lib/common/container'

module Handlers
	class Handler

    protected


    def create_container(fields)
      Common::Container::Container.new(fields)
    end
	end
end
