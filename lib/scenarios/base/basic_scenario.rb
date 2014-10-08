require './lib/configuration/context'
require './lib/configuration/environment_configuration'

module Scenarios
	class BasicScenario

    def initialize(context=Configuration::Context::DEVELOPMENT)
      Configuration::EnvironmentConfiguration::context = context
    end

		protected

		def extract
			raise Exception.new 'Method extract not implemented yet.'
		end

		def transform
			raise Exception.new 'Method transform not implemented yet.'
		end

		def load
			raise Exception.new 'Method load not implemented yet.'
		end
	end
end
