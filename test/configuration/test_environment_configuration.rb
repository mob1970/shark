require 'minitest/autorun'
require './lib/configuration/environment_configuration'

class TestEnvironmentConfiguration < Minitest::Unit::TestCase
  DEVELOPMENT_CONTEXT = 'development'
  PRODUCTION_CONTEXT = 'production'

  CONFIGURATION_FILE = './test/configuration/files/config/test_environment_configuration.yml'
  PRODUCTION_FILE_PATH = '/app/data/production'

  def setup
    Configuration::EnvironmentConfiguration.context = PRODUCTION_CONTEXT
    Configuration::EnvironmentConfiguration.configuration_file = CONFIGURATION_FILE
    @configuration = Configuration::EnvironmentConfiguration.instance
  end

  def test_context_production
    assert_equal PRODUCTION_CONTEXT, Configuration::EnvironmentConfiguration.context
  end

  def test_context_still_production
    Configuration::EnvironmentConfiguration.context = DEVELOPMENT_CONTEXT
    assert_equal PRODUCTION_CONTEXT, Configuration::EnvironmentConfiguration.context
  end

  def test_customers_reference
    assert_equal PRODUCTION_FILE_PATH, @configuration.technologies['CUSTOMERS'].reference
  end

  def test_mysql_reference
    assert_equal '', @configuration.technologies['MYSQL_DATABASE'].reference
  end

  def test_oracle_reference
    assert_equal 'production', @configuration.technologies['ORACLE_DATABASE'].reference
  end

end