require './lib/handlers/base/handler'
require './lib/common/container_list'

module Handlers
  class SQLHandler < Handlers::Handler
    attr_reader :technology

    def initialize(technology)
      @technology = technology
    end

    def read_each(table, filters)
      raise Exception.new 'Method read not implemented yet'
    end

    def insert(table, content)
      raise Exception.new 'Method insert not implemented yet'
    end

    def update(sql_sentence, content)
      raise Exception.new 'Method update not implemented yet'
    end

    def delete(sql_sentence)
      raise Exception.new 'Method delete not implemented yet'
    end

    def read(table, filters=[])
      list = Common::Container::ContainerList.new
      read_each(table, filters) do |container|
        list << container
      end

      list
    end

    protected

    def extract_columns_and_values(content)
      columns = []
      values = []
      content.fields.each do |field|
        columns << field
        values << "#{content.send(field)}"
      end

      [columns, values]
    end
  end
end