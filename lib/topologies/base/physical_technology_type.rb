module Topologies
  module PhysicalTechnologyType
    FILE = 'File'
    ORACLE = 'Oracle'
    MYSQL = 'MySQL'
    POSTGRESQL = 'Postgresql'
    SQLITE = 'SQLite'
    SQL_SERVER = 'Microsoft SQLServer'

    @classes = {
      FILE => 'Topologies::FileTechnology',
      ORACLE => 'Topologies::OracleTechnology',
      MYSQL => 'Topologies::MySqlTechnology',
      POSTGRESQL => 'Topologies::PostgreSqlTechnology',
      SQLITE => 'Topologies::SqlLiteTechnology',
      SQL_SERVER => 'Topologies::SqlServerTechnology'
    }

    def self.class_for_type(type)
      @classes[type]
    end
  end
end