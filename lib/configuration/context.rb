module Configuration
  module Context
    DEVELOPMENT = 0
    TEST = 1
    PRODUCTION = 2

    def self.string_representation(context)
      case
        when context == 0
          'development'
        when context == 1
          'test'
        when context == 2
          'production'
        else
          raise Exception.new("Invalid context integer value #{context}.")
      end
    end
  end
end
