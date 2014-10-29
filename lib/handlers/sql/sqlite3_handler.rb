require './lib/handlers/sql/base/sql_handler'
require './lib/topologies/file_sql_technology'
require './lib/topologies/base/physical_technology_type'
require './lib/handlers/sql/base/filter'
require './lib/common/container_list.rb'
require './lib/common/container.rb'
require './lib/common/container.rb'

require 'sqlite3'

module Handlers
  class Sqlite3Handler < Handlers::SQLHandler
    def read_each(table, filters=[])
      begin
        database = open_database
        sql_sentence = build_query(table, filters)
        results = database.execute(sql_sentence, obtain_filter_values(filters))
        results.each do |row|
          yield format_result(row)
        end
      ensure
        close_database(database)
      end
    end

    def insert(table, content)
      begin
        database = open_database
        columns, values = extract_columns_and_values(content)
        sql_sentence = build_insert_sentence(table, columns)
        database.execute(sql_sentence, values)
      ensure
        close_database(database)
      end
    end

    def update(sql_sentence, content)
    end

    def delete(sql_sentence)
    end

    private

    def open_database
      database = SQLite3::Database.new(@technology.physical_technology.file)
      database.results_as_hash = true

      database
    end

    def close_database(database)
      database.close if database
    end

    def build_query(table, filters)
      sentence = "SELECT * FROM #{table} WHERE 1=1 "
      filters.each do |filter|
        sentence += "AND #{filter.column} #{filter.evaluator} ?"
      end

      sentence
    end

    def build_insert_sentence(table, columns)
      "INSERT INTO #{table} (#{columns.join(', ')}) " +
      "VALUES (#{Array.new(columns.length, '?').join(', ')})"
    end

    def obtain_filter_values(filters)
      values = []
      filters.each do |filter|
        values << filter.value
      end

      values
    end

    def format_result(row)
      columns = obtain_columns(row)
      container = create_container(columns)
      columns.each do |column|
        container.send("#{column}=", row[column].to_s)
      end

      container
    end

    def obtain_columns(row)
      columns = []
      row.keys.each do |key|
        columns << key unless key.is_a?(Numeric)
      end

      columns
    end
  end
end
