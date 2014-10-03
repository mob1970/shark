require 'minitest/autorun'
require './lib/handlers/csv_handler.rb'

class TestCsvHandlerWithHeader < Minitest::Unit::TestCase
  TECHNOLOGY_REFERENCE = 'test/handlers/files/data/'

  CONFIGURATION_FILE = 'test/handlers/files/config/csv_handler_with_header.yml'
  EXPECTED_DATA_FILENAME = 'test/handlers/files/data/expected_csv_handler.csv'

  DATA_FILENAME = 'csv_handler_with_header.csv'
  OUTPUT_DATA_FILENAME = 'output_csv_handler_with_header.csv'

  FIELDS = %w(id first_name last_name)

  FIRST_RECORD = %w(1 Miquel Oliete)
  SECOND_RECORD = %w(2 Emili Parreño)
  THIRD_RECORD = %w(3 Andres Cirujeda)
  FOURTH_RECORD = %w(4 Xavier Noria)

  def setup
    technology = MiniTest::Mock.new
    technology.expect(:reference, TECHNOLOGY_REFERENCE)
    csv_handler = Handlers::CsvHandler.new(CONFIGURATION_FILE, technology)
    @information = csv_handler.read(DATA_FILENAME)
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

  def test_generated_file
    container_list = Common::Container::ContainerList.new
    container_list << create_container(FIELDS, FIRST_RECORD)
    container_list << create_container(FIELDS, SECOND_RECORD)
    container_list << create_container(FIELDS, THIRD_RECORD)
    container_list << create_container(FIELDS, FOURTH_RECORD)

    technology = MiniTest::Mock.new
    technology.expect(:reference, TECHNOLOGY_REFERENCE)
    csv_handler = Handlers::CsvHandler.new(CONFIGURATION_FILE, technology)
    csv_handler.write(OUTPUT_DATA_FILENAME, container_list)

    assert_equal File.read(EXPECTED_DATA_FILENAME), File.read(TECHNOLOGY_REFERENCE+OUTPUT_DATA_FILENAME)
  end

  private

  def create_container(fields, values)
    container = Common::Container::Container.new(fields)
    (0...fields.length).each do |i|
      container.send("#{fields[i]}=",values[i])
    end

    container
  end
end
