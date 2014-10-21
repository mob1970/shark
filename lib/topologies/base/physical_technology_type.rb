module Topologies
  module PhysicalTechnologyType
    FILE = 'File'
    ORACLE = 'Oracle'
    MYSQL = 'MySQL'
    POSTGRESQL = 'Postgresql'
    SQLITE3 = 'SQLite3'
    SQL_SERVER = 'Microsoft SQLServer'

    @classes = {
      FILE => 'Topologies::FileTechnology',
      ORACLE => 'Topologies::OracleTechnology',
      MYSQL => 'Topologies::MySqlTechnology',
      POSTGRESQL => 'Topologies::PostgresqlTechnology',
      SQLITE3 => 'Topologies::Sqlite3Technology',
      SQL_SERVER => 'Topologies::SqlServerTechnology'
    }

    def self.class_for_type(type)
      @classes[type]
    end
  end
end