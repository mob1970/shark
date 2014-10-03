require 'yaml'

module Handlers
  class DelimitedConfiguration
    attr_reader :fields

    def initialize(configuration_file)
      @fields =[]
      config = YAML.load_file(configuration_file)
      config['fields'].each do |item|
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