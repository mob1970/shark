require 'minitest/autorun'
require './lib/handlers/csv_configuration.rb'

class TestCsvConfigurationWithHeader < Minitest::Unit::TestCase
  CONFIGURATION_FILE = 'test/handlers/files/config/csv_handler_with_header.yml'

  def setup()
    @conf = Handlers::CsvConfiguration.new(CONFIGURATION_FILE)
  end

  def test_csv_separator
    assert_equal ';', @conf.separator
  end

  def test_header
    assert @conf.header?
  end

  def test_first_field
    assert_equal 'id', @conf.fields[0]
  end

  def test_last_field
    assert_equal 'last_name', @conf.fields[-1]
  end
end