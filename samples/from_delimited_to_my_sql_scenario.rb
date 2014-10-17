require './lib/scenarios/scenario'
require './lib/configuration/context'
require './lib/configuration/environment_configuration'
require './lib/handlers/sql/my_sql_handler'
require './lib/handlers/delimited_handler'
require './lib/handlers/sql/base/filter'
require './lib/handlers/sql/base/evaluator'
require './lib/common/mapper'
require './lib/common/mapping'

class FromDelimitedToMySQL_scenario < Scenarios::Scenario

  INPUT_CONFIG_FILE = 'config/input_delimited_handler.yml'
  INPUT_FILE_NAME = 'data/information.txt'

  protected

  def extract
    technology = Configuration::EnvironmentConfiguration.instance.technologies['SAMPLES_PATH']
    handler = Handlers::DelimitedHandler.new(INPUT_CONFIG_FILE, technology)
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
    handler = Handlers::MySQLHandler.new(Configuration::EnvironmentConfiguration.instance.technologies['MYSQL_DATABASE'])
    @container_list.each do |container|
      handler.insert('users', container)
    end
  end

  private

  def mapper_building
    result = Common::Container::Mapper.new
    result << Common::Container::Mapping.new('id', 'id')
    result << Common::Container::Mapping.new('first_name', 'first_name')
    result << Common::Container::Mapping.new('last_name', 'last_name')

    result
  end
end

Configuration::EnvironmentConfiguration.configuration_file = './samples/files/config/test_environment_configuration.yml'
scenario = FromDelimitedToMySQL_scenario.new(Configuration::Context::DEVELOPMENT)
scenario.do_job