module Common
	module Container
		class Mapping
			attr_reader :source, :target

			def initialize(source, target)
				@source, @target = source, target
			end
		end
	end
end
