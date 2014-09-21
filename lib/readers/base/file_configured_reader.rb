require 'yaml'
require './lib/readers/base/reader.rb'

module Readers
	class FileConfiguredReader < Readers::Reader
		attr_reader :configuration

		def initialize(configuration_file)
			@configuration = YAML.load_file(configuration_file)
		end
			       
	end
end
