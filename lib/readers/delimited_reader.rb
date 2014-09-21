require './lib/readers/base/file_configured_reader.rb'
require './lib/readers/delimited_configuration.rb'
require './lib/common/container_list.rb'
require './lib/common/container.rb'

module Readers
  class DelimitedReader < Readers::FileConfiguredReader
    def initialize(configuration_file)
      @configuration = Readers::DelimitedConfiguration.new(configuration_file)
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
        #container.send("#{field.name}=", line[field.start-1, field.length].strip)
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
  end
end
