require './lib/topologies/base/physical_technology'
require './lib/topologies/base/physical_technology_type'

module Topologies
  class FileTechnology < Topologies::PhysicalTechnology
    attr_reader :path

    def initialize(path)
      super(Topologies::PhysicalTechnologyType::FILE)
      @path = path
    end

    def reference
      path
    end
  end
end