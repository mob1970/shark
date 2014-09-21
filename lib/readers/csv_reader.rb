require './lib/readers/base/file_configured_reader.rb'
require './lib/readers/csv_configuration.rb'
require './lib/common/container_list.rb'
require './lib/common/container.rb'

module Readers
	class CsvReader < Readers::FileConfiguredReader
		def initialize(configuration_file)
			@configuration = Readers::CsvConfiguration.new(configuration_file)
		end

		def read(file_path)
			list = Common::Container::ContainerList.new
			File.open(file_path, 'r').each_line do |line|
				container = extract_info_from_line(line.chomp)
				list << container
			end

			list
		end

		private

		def create_container()
			Common::Container::Container.new(@configuration.fields)
		end

		def extract_info_from_line(line)
			container = create_container
			values = line.split(@configuration.separator)
			raise Exception.new('Number of fields not equal number of values') if values.length != @configuration.fields.length
			(0..@configuration.fields.length-1).each do |i| 
				container.send("#{@configuration.fields[i]}=", values[i])
			end

			container
		end
  end
end
