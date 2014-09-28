require './lib/topologies/base/physical_technology'
require './lib/topologies/base/physical_technology_type'

module Topologies
  class SQLTechnology < Topologies::PhysicalTechnology
    attr_reader :connection_string, :user, :password

    def initialize(sql_type, connection_string, user, password)
      super(sql_type)
      @connection_string = connection_string
      @user = user
      @password = password
    end
  end
end