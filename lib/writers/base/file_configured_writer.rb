require 'yaml'
require './lib/writers/base/writer.rb'

module Writers
	class FileConfiguredWriter < Writers::Writer
		attr_reader :configuration

		def initialize(configuration_file)
			@configuration = YAML.load_file(configuration_file)
		end
	end
end
