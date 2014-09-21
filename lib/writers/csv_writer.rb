require './lib/writers/base/file_configured_writer.rb'
require './lib/writers/csv_configuration.rb'
require './lib/common/container_list.rb'
require './lib/common/container.rb'

module Writers
	class CsvWriter < Writers::FileConfiguredWriter
		def initialize(configuration_file)
			@configuration = Writers::CsvConfiguration.new(configuration_file)
	  end

    def write(file_to_write, content)
      File.open(file_to_write, 'w') do |file|
        file.write(@configuration.fields.join(@configuration.separator) + "\n") if @configuration.header?
        content.each do |container|
          content = []
          @configuration.fields.each do |field|
            content << container.send(field)
          end
          file.write(content.join(@configuration.separator)+"\n")
        end
      end
    end
  end
end

