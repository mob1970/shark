require 'minitest/autorun'
require './lib/handlers/delimited_handler.rb'

class TestDelimitedHandler < Minitest::Unit::TestCase
  TECHNOLOGY_REFERENCE = 'test/handlers/files/data/'

  CONFIGURATION_FILE = 'test/handlers/files/config/delimited_handler.yml'
  DATA_FILE = 'delimited_handler.txt'

  EXPECTED_DATA_FILENAME = 'expected_delimited_writer.txt'
  OUTPUT_DATA_FILENAME = 'delimited_writer.txt'

  FIELDS = %w(id first_name last_name)

  FIRST_RECORD = %w(1 Miquel Oliete)
  SECOND_RECORD = %w(2 Emili Parreño)
  THIRD_RECORD = %w(3 Andres Cirujeda)
  FOURTH_RECORD = %w(4 Xavier Noria)

  def setup
    technology = MiniTest::Mock.new
    technology.expect(:reference, TECHNOLOGY_REFERENCE)
    delimited_handler = Handlers::DelimitedHandler.new(CONFIGURATION_FILE, technology)
    @information = delimited_handler.read(DATA_FILE)
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

  def test_generated_file
    container_list = Common::Container::ContainerList.new
    container_list << create_container(FIELDS, FIRST_RECORD)
    container_list << create_container(FIELDS, SECOND_RECORD)
    container_list << create_container(FIELDS, THIRD_RECORD)
    container_list << create_container(FIELDS, FOURTH_RECORD)

    technology = MiniTest::Mock.new
    technology.expect(:reference, TECHNOLOGY_REFERENCE)
    delimited_handler = Handlers::DelimitedHandler.new(CONFIGURATION_FILE, technology)
    delimited_handler.write(OUTPUT_DATA_FILENAME, container_list)

    assert_equal File.read(TECHNOLOGY_REFERENCE+EXPECTED_DATA_FILENAME), File.read(TECHNOLOGY_REFERENCE+OUTPUT_DATA_FILENAME)
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