require './lib/scenarios/scenario'
require './lib/configuration/context'
require './lib/configuration/environment_configuration'
require './lib/handlers/csv_handler'
require './lib/handlers/sql/my_sql_handler'
require './lib/handlers/sql/base/filter'
require './lib/handlers/sql/base/evaluator'
require './lib/common/mapper'
require './lib/common/mapping'

class FromMySQLToCsvScenario < Scenarios::Scenario
  OUTPUT_CONFIG_FILE = 'config/output_csv_handler_with_header.yml'
  OUTPUT_FILE_NAME = 'data/output_information_from_mysql.csv'

  protected

  def extract
    handler = Handlers::MySQLHandler.new(Configuration::EnvironmentConfiguration.instance.technologies['MYSQL_DATABASE'])
    @container_list = handler.read('users')
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

Configuration::EnvironmentConfiguration.configuration_file = './samples/files/config/test_environment_configuration.yml'
scenario = FromMySQLToCsvScenario.new(Configuration::Context::DEVELOPMENT)
scenario.do_job