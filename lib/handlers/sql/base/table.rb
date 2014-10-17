module Handlers
  module SQL
    class Table
      attr_reader :name, :columns

      def initialize(name, columns=[])
        @name, @columns = name, columns
      end
    end

    class Column
      attr_reader :name, :type, :nullable, :key

      def initialize(name, type, key=false, nullable=false)
        @name, @type, @nullable, @key = name, type, key, nullable
      end
    end

    class ColumnType
      INTEGER =1
      STRING = 2
      DATE = 3
      DATETIME = 4
      DECIMAL = 5
      TEXT = 6
    end
  end
end