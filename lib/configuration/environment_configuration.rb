require 'singleton'
require 'yaml'

require './lib/topologies/base/logical_technology.rb'

module Configuration
  class EnvironmentConfiguration
      include Singleton

    LOGICAL_TECHNOLOGIES = 'logical_technologies'
    #CONFIGURATION_FILE = 'config/environment.yml'
    CONFIGURATION_FILE = 'scripts/template_files/environment.yml'

    attr_reader :technologies

    def initialize
      initialize_technologies
    end

    def self.context
      @@context || 'development'
    end

    def self.context=(context)
      @@context ||= context
    end

    private

    def initialize_technologies
      config = YAML.load_file(CONFIGURATION_FILE)
      @technologies = Hash.new

      config[LOGICAL_TECHNOLOGIES].each do |technology|
        @technologies[technology['name']] = Topologies::LogicalTechnology.new(technology, @@context)
      end
    end
  end
end

Configuration::EnvironmentConfiguration::context = 'production'
conf = Configuration::EnvironmentConfiguration.instance
p conf::context
