require './lib/readers/base/file_configured_reader.rb'
require './lib/readers/csv_configuration.rb'
require './lib/common/container_list.rb'
require './lib/common/container.rb'

module Readers
	class CsvReader < Readers::FileConfiguredReader
		def initialize(configuration_file, technology)
			@configuration = Readers::CsvConfiguration.new(configuration_file)
      @technology = technology
		end

		def read(file_path)
			list = Common::Container::ContainerList.new
			File.open(@technology.reference+file_path, 'r').drop(lines_to_jump).each do |line|
        list << extract_info_from_line(line.chomp, create_container)
			end

			list
		end

		private

    def lines_to_jump
      @configuration.header? ? 1 : 0
    end

		def create_container
			Common::Container::Container.new(@configuration.fields)
		end

		def extract_info_from_line(line, container)
			values = line.split(@configuration.separator)
			raise Exception.new('Number of fields not equal number of values') if values.length != @configuration.fields.length
			(0..@configuration.fields.length-1).each do |i| 
				container.send("#{@configuration.fields[i]}=", values[i])
			end

			container
		end
  end
end
