require 'yaml'

module Readers
	class CsvConfiguration
		attr_accessor :separator, :fields
		attr_writer :header

		def initialize(configuration_file)
			config = YAML.load_file(configuration_file)
			@separator = config['separator']
			@fields = config['fields']
			@header = 'true'.upcase == (config['header'] ? config['header'] : '').upcase
		end

		def header?
			@header
		end
  end
end
