require './lib/handlers/base/handler'

module Handlers
  class SQLHandler < Handlers::Handler
    def read(table, filters)
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
  end
end