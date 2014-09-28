module Topologies
  class PhysicalTechnology
    def initialize(type)
      @type = type
    end

    def reference
      raise Exception.new('Method reference not implemented.')
    end
  end
end