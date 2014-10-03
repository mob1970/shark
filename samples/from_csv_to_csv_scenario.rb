require './lib/scenarios/scenario.rb'
require './lib/handlers/csv_handler'
require './lib/common/container'
require './lib/common/container_list'
require './lib/common/mapper'
require './lib/common/mapping'

class FromCsvToCsvScenario < Scenarios::Scenario
  TECHNOLOGY_REFERENCE = './samples/files/data/'

  INPUT_CONFIG_FILE = './samples/files/config/csv_r_without_header.yml'
  INPUT_FILE_PATH = 'information.csv'

  OUTPUT_CONFIG_FILE = './samples/files/config/csv_writer.yml'
  OUTPUT_FILE_PATH = 'output_information.csv'

  def extract
    technology = MiniTest::Mock.new
    technology.expect(:reference, TECHNOLOGY_REFERENCE)
    handler = Handlers::CsvHandler.new(INPUT_CONFIG_FILE, technology)
    @container_list = handler.read(INPUT_FILE_PATH)
  end

  def transform
    mapper = mapper_building

    @content = Common::Container::ContainerList.new
    @container_list.each do |container|
      @content << mapper.map(container)
    end
  end

  def load
    technology = MiniTest::Mock.new
    technology.expect(:reference, TECHNOLOGY_REFERENCE)
    handler = Handlers::CsvHandler.new(OUTPUT_CONFIG_FILE, technology)
    handler.write(OUTPUT_FILE_PATH, @content)
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
scenario.do_job
