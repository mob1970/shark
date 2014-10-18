require './lib/scenarios/scenario'
require './lib/handlers/csv_handler'
require './lib/handlers/csv_configuration'
require './lib/common/container'
require './lib/common/container_list'
require './lib/common/mapper'
require './lib/common/mapping'
require './lib/configuration/context'
require './lib/configuration/environment_configuration'

class FromCsvToCsvScenario < Scenarios::Scenario
  TECHNOLOGY_REFERENCE = './samples/files/data/'

  INPUT_CONFIG_FILE = 'config/input_csv_handler_without_header.yml'
  INPUT_FILE_PATH = 'data/information.csv'

  OUTPUT_CONFIG_FILE = 'config/output_csv_handler_with_header.yml'
  OUTPUT_FILE_PATH = 'data/output_information.csv'

  def extract
    technology = Configuration::EnvironmentConfiguration.instance.technologies['SAMPLES_PATH']
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
    technology = Configuration::EnvironmentConfiguration.instance.technologies['SAMPLES_PATH']
    output_csv_configuration = build_output_csv_configuration

    handler = Handlers::CsvHandler.new(output_csv_configuration, technology)
    handler.write(OUTPUT_FILE_PATH, @content)
  end

  private

  def build_output_csv_configuration
    Handlers::CsvConfiguration.new(:separator => ';',
                                   :fields => %W(identifier firstname lastname),
                                   :header => true)
  end

  def mapper_building
    result = Common::Container::Mapper.new
    result << Common::Container::Mapping.new('id', 'identifier')
    result << Common::Container::Mapping.new('first_name', 'firstname')
    result << Common::Container::Mapping.new('last_name', 'lastname')

    result
  end

end

Configuration::EnvironmentConfiguration.configuration_file = './samples/files/config/test_environment_configuration.yml'
scenario = FromCsvToCsvScenario.new(Configuration::Context::PRODUCTION)
scenario.do_job
