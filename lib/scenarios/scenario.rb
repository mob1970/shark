require './lib/scenarios/base/basic_scenario.rb'

module Scenarios
	class Scenario < Scenarios::BasicScenario
		def initialize()
		end

		def do_job()
			extract()
			transform()
			load()
		end
	end
end
