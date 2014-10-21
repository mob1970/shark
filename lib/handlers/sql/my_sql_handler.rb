require './lib/handlers/sql/base/sql_handler'
require './lib/topologies/my_sql_technology'
require './lib/handlers/sql/base/filter'
require './lib/common/container_list.rb'
require './lib/common/container.rb'
require './lib/common/container.rb'

require 'mysql2'

module Handlers
  class MySQLHandler < Handlers::SQLHandler
    def read(table, filters=[])
      begin
        client = create_client
        sql_sentence = build_query(table, filters)
        results = client.query(sql_sentence)
        data = format_results(results)
      rescue Mysql2::Error => mysql_error
        data = Common::Container::ContainerList.new
      ensure
        close_connection(client)
      end

      data
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

    def format_results(results)
      list = Common::Container::ContainerList.new

      fields = results.fields
      results.each(:as => :array) do |row|
        container = create_container(fields)
        (0...fields.length).each do |index|
          container.send("#{fields[index]}=", row[index])
        end
        list << container
      end

      list
    end

    def create_container(fields)
      Common::Container::Container.new(fields)
    end

    def extract_columns_and_values(content)
      columns = []
      values = []
      content.fields.each do |field|
        columns << field
        values << "'#{content.send(field)}'"
      end

      [columns, values]
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