require './lib/topologies/server_sql_technology'
require './lib/topologies/base/physical_technology_type'

module Topologies
  class MySqlTechnology  < Topologies::ServerSQLTechnology
    def initialize(context)
      super(Topologies::PhysicalTechnologyType::MYSQL,
            context['host'],
            context['port'],
            context['user'],
            context['password'],
            context['database'])
    end

    def reference
      ''
    end
  end
end