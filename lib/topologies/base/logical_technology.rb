require './lib/configuration/context'
require './lib/topologies/base/physical_technology_type'
require './lib/topologies/file_technology'
require './lib/topologies/my_sql_technology'
require './lib/topologies/oracle_technology'

module Topologies
  class LogicalTechnology
    attr_reader :name, :physical_technology

    def initialize(config, context)
      build_structure(config, Configuration::Context.string_representation(context))
    end

    def reference
      @physical_technology.reference
    end

    private

    def build_structure(config, context)
      techs = config['physical_technologies']
      @name = config['name']
      @physical_technology = case config['type']
                                 when Topologies::PhysicalTechnologyType::FILE
                                   Topologies::FileTechnology.new(techs[context])
                                 when Topologies::PhysicalTechnologyType::MYSQL
                                   Topologies::MySqlTechnology.new(techs[context])
                                 when Topologies::PhysicalTechnologyType::ORACLE
                                   Topologies::OracleTechnology.new(techs[context])
                                 else
                                   raise Exception.new("Type #{config['type']} is not a valid type.")
                               end
    end
  end
end