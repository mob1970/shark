require './lib/topologies/sql_technology'
require './lib/topologies/base/physical_technology_type'

module Topologies
  class MySqlTechnology  < Topologies::SQLTechnology

    def initialize(context)
      super(Topologies::PhysicalTechnologyType::MYSQL, context['connection_string'],
            context['user'],
            context['password'])
    end

    def reference
      ''
    end
  end
end