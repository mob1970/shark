require 'minitest/autorun'
require './lib/readers/csv_reader.rb'

class TestCsvReaderWithHeader < Minitest::Unit::TestCase
  CONFIGURATION_FILE = 'test/readers/files/config/csv_reader_without_header.yml'
  DATA_FILE = 'test/readers/files/data/csv_reader.csv'

  def setup
    csv_reader = Readers::CsvReader.new(CONFIGURATION_FILE)
    @information = csv_reader.read(DATA_FILE)
  end

  def test_first_element_id
    assert_equal '1', @information[0].id
  end

  def test_first_element_last_name
    assert_equal 'Oliete', @information[0].last_name
  end

  def test_last_element_id
    assert_equal '4',@information[-1].id
  end

  def test_last_element_last_name
    assert_equal 'Noria', @information[-1].last_name
  end
end
