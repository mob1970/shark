require './lib/topologies/sql_technology'

module Topologies
  class ServerSQLTechnology < Topologies::SQLTechnology
    attr_reader :host, :port, :user, :password, :database

    def initialize(sql_type, host, port, user, password, database)
      super(sql_type)
      @host = host
      @port = port
      @user = user
      @password = password
      @database = database
    end
  end
end