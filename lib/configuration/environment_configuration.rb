require 'singleton'
require 'yaml'

require './lib/topologies/base/logical_technology.rb'
require './lib/configuration/context'

module Configuration
  class EnvironmentConfiguration
      include Singleton

    LOGICAL_TECHNOLOGIES = 'logical_technologies'
    DEFAULT_CONFIGURATION_FILE = 'config/environment.yml'
    #CONFIGURATION_FILE = 'scripts/template_files/environment.yml'

    attr_reader :technologies

    def initialize
      initialize_technologies
    end

    def self.context
      @@context
    end

    def self.context=(context)
      @@context ||= context
    end

    def self.configuration_file=(configuration_file)
      @@configuration_file = configuration_file
    end

    private

    def initialize_technologies
      @@context = Configuration::Context::DEVELOPMENT unless @@context

      @technologies = Hash.new
      config = YAML.load_file(@@configuration_file || DEFAULT_CONFIGURATION_FILE)
      config[LOGICAL_TECHNOLOGIES].each do |technology|
        @technologies[technology['name']] = Topologies::LogicalTechnology.new(technology, @@context)
      end
    end
  end
end

