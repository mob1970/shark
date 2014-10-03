require 'yaml'
require './lib/handlers/base/handler.rb'

module Handlers
	class FileConfiguredHandler < Handlers::Handler
		attr_reader :configuration

		def initialize(configuration_file)
			@configuration = YAML.load_file(configuration_file)
		end
			       
	end
end
