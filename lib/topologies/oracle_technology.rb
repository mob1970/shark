require './lib/topologies/server_sql_technology'
require './lib/topologies/base/physical_technology_type'

module Topologies
  class OracleTechnology < Topologies::ServerSQLTechnology
    attr_reader :schema

    def initialize(context)
      super(Topologies::PhysicalTechnologyType::ORACLE,
            context['host'],
            context['port'],
            context['user'],
            context['password'],
            context['database'])
      @schema = context['schema']
    end

    def reference
      @schema
    end
  end
end
