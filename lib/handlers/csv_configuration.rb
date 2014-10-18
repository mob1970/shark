require 'yaml'

module Handlers
	class CsvConfiguration
    DEFAULT_SEPARATOR = ','
    DEFAULT_HAS_HEADER = true

		attr_accessor :separator, :fields
		attr_writer :header

		def initialize(options)
      if options.is_a? String
        extract_config_from_file(options)
      elsif options.is_a? Hash
        normalized_options = normalize_keys(options)
        if normalized_options.has_key?(:filename)
          extract_config_from_file(normalized_options[:config_file])
        else
          extract_config_from_params(normalized_options)
        end
      end
    end

		def header?
			@header
    end

    private

    def normalize_keys(options)
      normalized_options = Hash.new
      options.each_key do |key|
        normalized_options[key.to_sym] = options[key]
      end

      normalized_options
    end

    def extract_config_from_file(file_path)
      config = YAML.load_file(file_path)
      @separator = config['separator']
      @fields = config['fields']
      @header = config['header']
    end

    def extract_config_from_params(options)
      @separator = options.has_key?(:separator) ? options[:separator] : DEFAULT_SEPARATOR
      @header= options.has_key?(:header) ? options[:header] : DEFAULT_HAS_HEADER
      @fields= options[:fields]
    end

  end
end
