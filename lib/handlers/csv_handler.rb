require './lib/handlers/base/file_configured_handler.rb'
require './lib/handlers/csv_configuration.rb'
require './lib/common/container_list.rb'
require './lib/common/container.rb'

module Handlers
	class CsvHandler < Handlers::FileConfiguredHandler
		def initialize(configuration_file, technology)
			@configuration = Handlers::CsvConfiguration.new(technology.reference+configuration_file)
      @technology = technology
		end

		def read(file_path)
			list = Common::Container::ContainerList.new
			File.open(@technology.reference+file_path, 'r').drop(lines_to_jump).each do |line|
        list << extract_info_from_line(line.chomp, create_container)
			end

			list
    end

    def write(file_path, content)
      File.open(@technology.reference+file_path, 'w') do |file|
        file.write(@configuration.fields.join(@configuration.separator) + "\n") if @configuration.header?
        content.each do |container|
          record = []
          @configuration.fields.each do |field|
            record << container.send(field)
          end
          file.write(record.join(@configuration.separator)+"\n")
        end
      end
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
