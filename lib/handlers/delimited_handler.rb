require './lib/handlers/base/file_handler.rb'
require './lib/handlers/delimited_configuration.rb'
require './lib/common/container_list.rb'
require './lib/common/container.rb'

module Handlers
  class DelimitedHandler < Handlers::FileHandler
    def initialize(configuration_file, technology)
      @configuration = Handlers::DelimitedConfiguration.new(technology.reference+configuration_file)
      @technology = technology
    end

    def read(file_path)
      list = Common::Container::ContainerList.new
      File.open(@technology.reference+file_path, 'r').each_line do |line|
        container = extract_info_from_line(line.chomp)
        list << container
      end

      list
    end

    def write(file_path, content)
      File.open(@technology.reference+file_path, 'w') do |file|
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

    def create_container(fields)
      Common::Container::Container.new(fields)
    end

    def create_fields_array(configuration)
      fields = []
      configuration.fields.each do |item|
        fields << item.name
      end

      fields
    end

    def extract_info_from_line(line)
      fields = create_fields_array(@configuration)
      container = create_container(fields)
      @configuration.fields.each do |field|
        container.send("#{field.name}=", safe_substring(line, field.start, field.length))
      end

      container
    end

    def safe_substring(text, start, length)
      return nil unless longer?(text , start)
      result = text[start-1,text.length]
      return result.strip unless longer?(result , length)
      result[0, length].strip
    end

    def longer?(text, length)
      text && text.length > length
    end

    def right_start_position?(record, start_position)
      record.length == start_position-1
    end

    def fill_record(record, total_length)
      record.ljust(total_length-1)
    end
  end
end
