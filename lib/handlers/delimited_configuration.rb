require 'yaml'

module Handlers
  class DelimitedConfiguration
    attr_reader :fields

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

    private

    def normalize_keys(options)
      normalized_options = Hash.new
      options.each_key do |key|
        normalized_options[key.to_sym] = options[key]
      end

      normalized_options
    end

    def extract_config_from_file(file_path)
      @fields =[]
      config = YAML.load_file(file_path)
      config['fields'].each do |item|
        @fields << Handlers::DelimitedConfigurationField.new(item)
      end
    end

    def extract_config_from_params(options)
      options['fields'].each do |item|
        @fields << Handlers::DelimitedConfigurationField.new(item)
      end
    end
  end

  class DelimitedConfigurationField
    attr_reader :name, :start, :length

    def initialize(element)
      @name, @start, @length = element['name'], element['start'].to_i, element['length'].to_i
    end
  end
end