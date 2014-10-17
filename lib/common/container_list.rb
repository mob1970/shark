module Common
	module Container
		class ContainerList
			def initialize
				@elements = []
			end

			def <<(element)
				@elements << element
			end

			def [](index)
				@elements[index]
			end

			def each
				@elements.each do |element|
					yield element
				end
			end
		end
	end
end
