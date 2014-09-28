require './lib/scenarios/base/basic_scenario.rb'

module Scenarios
	class Scenario < Scenarios::BasicScenario
		def do_job
      initialize_environment
      process
    end

    def process
			extract
			transform
			load
    end

    private

    def initialize_environment

    end
	end
end
