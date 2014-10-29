require './lib/handlers/sql/base/sql_handler'
require './lib/topologies/oracle_technology'

require 'oci8'


module Handlers
  class OracleHandler < Handlers::SQLHandler

=begin
    def read(table, filters=[])
      begin
        connection = create_connection
        sql_sentence = build_query(table, filters)
        columns, values = extract_columns_and_values(content)
        results = connection.exec(sql_sentence,values)
        data = format_results(results)
      rescue Exception => ex
        data = Common::Container::ContainerList.new
      ensure
        close_connection(connection)
      end

      data
    end
=end

    def read_each(table, filters=[])
      begin
        connection = create_connection
        sql_sentence = build_query(table, filters)
        columns, values = extract_columns_and_values(content)
        results = connection.exec(sql_sentence,values)
        results.each do |row|
          yield format_result(row, columns)
        end
      ensure
        close_connection(connection)
      end
    end

    def insert(table, content)
      begin
        connection = create_connection
        columns, values = extract_columns_and_values(content)
        sql_sentence = build_insert_sentence(table, columns,values)
        connection.exec(sql_sentence, values)
      ensure
        close_connection(connection)
      end
    end

    def update(sql_sentence, content)
    end

    def delete(sql_sentence)
    end

    private

    def create_connection
      connection_url = "//#{@technology.physical_technology.host}:#{@technology.physical_technology.port}" +
                       "/#{@technology.physical_technology.database}"
      OCI8.new(@technology.physical_technology.user,
               @technology.physical_technology.password,
               connection_url)
    end

    def close_connection(connection)
      connection.logoff if connection
    end

    def build_query(table, filters=[])
      schema = (@technology.physical_technology.schema) ? "#{@technology.physical_technology.schema}." : ''
      sentence = "SELECT * FROM #{schema}#{table} WHERE 1=1 "
      index = 1
      filters.each do |filter|
        sentence += "AND #{filter.column} #{filter.evaluator} :#{index}"
        index += 1
      end

      sentence
    end

    def format_result(result, fields)
      container = create_container(fields)
      (0...fields.length).each do |index|
        container.send("#{fields[index]}=", result[index])
      end

      container
    end

    def build_insert_sentence(table, columns, values)
      schema = (@technology.physical_technology.schema) ? "#{@technology.physical_technology.schema}." : ''
      sentence = "INSERT INTO #{schema}#{table} ("
      sentence += columns.join(', ')
      sentence += ') VALUES ('
      (1..columns.length).each do |index|
        sentence += ', ' unless index == 1
        sentence += ":#{index}"
      end
      sentence += ') '
    end
  end
end


oh = Handlers::OracleHandler.new()