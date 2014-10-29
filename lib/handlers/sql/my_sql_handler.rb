require './lib/handlers/sql/base/sql_handler'
require './lib/topologies/my_sql_technology'
require './lib/handlers/sql/base/filter'
require './lib/common/container_list.rb'
require './lib/common/container.rb'
require './lib/common/container.rb'

require 'mysql2'

module Handlers
  class MySQLHandler < Handlers::SQLHandler
    def read_each(table, filters=[])
      begin
        client = create_client
        sql_sentence = build_query(table, filters)
        results = client.query(sql_sentence)
        results.each do |row|
          yield format_result(row, results.fields)
        end
      ensure
        close_connection(client)
      end
    end

    def insert(table, content)
      begin
        client = create_client
        columns, values = extract_columns_and_values(content)
        sql_sentence = build_insert_sentence(table, columns,values)
        client.query(sql_sentence)
      ensure
        close_connection(client)
      end
    end

    def update(sql_sentence, content)
    end

    def delete(sql_sentence)
    end

    private

    def create_client
      Mysql2::Client.new(:host => @technology.physical_technology.host, :port => @technology.physical_technology.port,
                         :username => @technology.physical_technology.user, :password => @technology.physical_technology.password,
                         :database => @technology.physical_technology.database)
    end

    def close_connection(client)
      client.close if client
    end

    def build_query(table, filters=[])
      sentence = "SELECT * FROM `#{table}` WHERE 1=1 "
      filters.each do |filter|
        sentence += "AND #{filter.column} #{filter.evaluator} #{filter.value}"
      end

      sentence
    end

    def format_result(row, fields)
      container = create_container(fields)
      (0...fields.length).each do |index|
        container.send("#{fields[index]}=", row[fields[index]])
      end

      container
    end

    def build_insert_sentence(table, columns, values)
      "INSERT INTO #{table} (#{columns.join(', ')}) VALUES (#{values.join(', ')}) "

=begin
      sentence = "INSERT INTO #{table} ("
      sentence += columns.join(', ')
      sentence += ') VALUES ('
      sentence += Array.new(columns.length, '?').join(', ')
      sentence += ') '

      sentence
=end
    end
  end
end