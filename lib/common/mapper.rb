require './lib/common/container'

module Common
	module Container
		class Mapper
			def initialize
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

      #def map(source, automatic=false)
      def map(source)
        target = Common::Container::Container.new(build_target_elements_list)
        #map_automatically(source, target) if automatic
        @mappings.each do |mapping|
          target.send("#{mapping.target}=", source.send(mapping.source))
        end

        target
      end

      private

      #def map_automatically(source, target)
      #  source.fields.each do |field|
      #    target.send("#{field}=", source.send(field)) if target.respond_to?("#{field}=")
      #  end
      #end

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
