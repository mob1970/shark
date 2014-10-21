require './lib/topologies/file_sql_technology'
require './lib/topologies/base/physical_technology_type'

module Topologies
  class Sqlite3Technology < Topologies::FileSQLTechnology
    attr_reader :file

    def initialize(context)
      super(Topologies::PhysicalTechnologyType::SQLITE3, context['file'])
    end

    def reference
      ''
    end
  end
end