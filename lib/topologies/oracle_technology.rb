require './lib/topologies/sql_technology'
require './lib/topologies/base/physical_technology_type'

module Topologies
  class OracleTechnology < Topologies::SQLTechnology
    attr_reader :schema

    def initialize(context)
      super(Topologies::PhysicalTechnologyType::ORACLE, context['connection_string'],
                                      context['user'],
                                      context['password'])
      @schema = context['schema']
    end

    def reference
      @schema
    end
  end
end
