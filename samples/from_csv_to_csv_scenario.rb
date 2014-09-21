require './lib/scenarios/scenario.rb'
require './lib/readers/csv_reader'
require './lib/writers/csv_writer'
require './lib/common/container'
require './lib/common/container_list'
require './lib/common/mapper'
require './lib/common/mapping'

class FromCsvToCsvScenario < Scenarios::Scenario
  INPUT_CONFIG_FILE = './samples/files/config/csv_reader_without_header.yml'
  INPUT_FILE_PATH = './samples/files/data/information.csv'

  OUTPUT_CONFIG_FILE = './samples/files/config/csv_writer.yml'
  OUTPUT_FILE_PATH = './samples/files/data/output_information.csv'

  def extract
    reader = Readers::CsvReader.new(INPUT_CONFIG_FILE)
    @container_list = reader.read(INPUT_FILE_PATH)
  end

  def transform
    mapper = mapper_building()

    @content = Common::Container::ContainerList.new
    @container_list.each do |container|
      @content << mapper.map(container)
    end
  end

  def load
    writer = Writers::CsvWriter.new(OUTPUT_CONFIG_FILE)
    writer.write(OUTPUT_FILE_PATH, @content)
  end

  private

  def mapper_building
    result = Common::Container::Mapper.new
    result << Common::Container::Mapping.new('id', 'identifier')
    result << Common::Container::Mapping.new('first_name', 'firstname')
    result << Common::Container::Mapping.new('last_name', 'lastname')

    result
  end

end

scenario = FromCsvToCsvScenario.new
scenario.do_job()
