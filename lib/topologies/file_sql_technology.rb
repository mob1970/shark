require './lib/topologies/sql_technology'

module Topologies
  class FileSQLTechnology < Topologies::SQLTechnology
    attr_reader :file

    def initialize(sql_type, file)
      super(sql_type)
      @file = file
    end
  end
end