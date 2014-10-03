require './lib/scenarios/scenario.rb'
require './lib/handlers/delimited_handler'
require './lib/handlers/csv_handler'
require './lib/common/container'
require './lib/common/container_list'
require './lib/common/mapper'
require './lib/common/mapping'

class FromDelimitedToCsvScenario < Scenarios::Scenario
  TECHNOLOGY_REFERENCE = './samples/files/data/'

  INPUT_CONFIG_FILE = './samples/files/config/delimited_reader.yml'
  INPUT_FILE_NAME = 'information.txt'

  OUTPUT_CONFIG_FILE = './samples/files/config/csv_writer.yml'
  OUTPUT_FILE_NAME = 'output_information2.csv'

  def extract
    handler = Handlers::DelimitedHandler.new(INPUT_CONFIG_FILE)
    @container_list = handler.read(INPUT_FILE_NAME)
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
    handler.write(OUTPUT_FILE_NAME, @content)
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

scenario = FromDelimitedToCsvScenario.new
scenario.do_job