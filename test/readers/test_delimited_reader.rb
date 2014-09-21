require 'minitest/autorun'
require './lib/readers/delimited_reader.rb'

class TestDelimitedReader < Minitest::Unit::TestCase
  CONFIGURATION_FILE = 'test/readers/files/config/delimited_reader.yml'
  DATA_FILE = 'test/readers/files/data/delimited_reader.txt'

  def setup
    delimited_reader = Readers::DelimitedReader.new(CONFIGURATION_FILE)
    @information = delimited_reader.read(DATA_FILE)
  end

  def test_first_element_id
    assert_equal '1', @information[0].id
  end

  def test_first_element_first_name
    assert_equal 'Miquel', @information[0].first_name
  end

  def test_first_element_last_name
    assert_equal 'Oliete', @information[0].last_name
  end

  def test_last_element_id
    assert_equal '4',@information[-1].id
  end

  def test_last_element_first_name
    assert_equal 'Xavier', @information[-1].first_name
  end

  def test_last_element_last_name
    assert_equal 'Noria', @information[-1].last_name
  end
end