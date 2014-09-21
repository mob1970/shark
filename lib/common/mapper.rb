require './lib/common/container'

module Common
	module Container
		class Mapper
			def initialize()
				@mappings = []
			end

			def <<(mapping)
				@mappings << mapping
			end

			def [](index)
				@mappings[index]
			end

			def each
				@mappings.each do |element|
					yield element
				end
      end

      def map(source, automatic=false)
        target = Common::Container::Container.new(build_target_elements_list)
        automatic_mapping() if automatic
        @mappings.each do |mapping|
          target.send("#{mapping.target}=", source.send(mapping.source))
        end

        target
      end

      private

      def build_target_elements_list
        result = []
        @mappings.each do |mapping|
          result << mapping.target
        end

        result
      end
		end
	end
end
