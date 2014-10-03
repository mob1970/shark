require 'minitest/autorun'
require './lib/handlers/delimited_configuration'

class TestDelimitedConfiguration < MiniTest::Unit::TestCase
  CONFIGURATION_FILE = 'test/handlers/files/config/delimited_handler.yml'

  def setup
    @conf = Handlers::DelimitedConfiguration.new(CONFIGURATION_FILE)
  end

  def test_first_field_name
    assert_equal 'id', @conf.fields[0].name
  end

  def test_first_field_start
    assert_equal 1, @conf.fields[0].start
  end

  def test_first_field_length
    assert_equal 10, @conf.fields[0].length
  end

  def test_last_field_name
    assert_equal 'last_name', @conf.fields[-1].name
  end

  def test_last_field_start
    assert_equal 62, @conf.fields[-1].start
  end

  def test_last_field_length
    assert_equal 50, @conf.fields[-1].length
  end
end