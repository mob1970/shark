module Handlers
  module SQL
    class Filter
      attr_reader :column, :evaluator, :value

      def initialize(column, evaluator, value)
        @column, @evaluator, @value = column, evaluator, value
      end
    end
  end
end