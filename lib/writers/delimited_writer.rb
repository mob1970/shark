require './lib/writers/base/file_configured_writer.rb'
require './lib/writers/delimited_configuration.rb'
require './lib/common/container_list.rb'
require './lib/common/container.rb'

module Writers
  class DelimitedWriter< FileConfiguredWriter
    def initialize(configuration_file)
      @configuration = Writers::DelimitedConfiguration.new(configuration_file)
    end

    def write(file_to_write, content)
      File.open(file_to_write, 'w') do |file|
        content.each do |container|
          record = ''
          @configuration.fields.each do |field|
            fill_record(record, field.start) unless right_start_position?(record, field.start)
            record += container.send(field.name).ljust(field.length)
          end
          file.write(record+"\n")
        end
      end
    end

    private

    def right_start_position?(record, start_position)
      record.length == start_position-1
    end

    def fill_record(record, total_length)
      record.ljust(total_length-1)
    end
  end
end