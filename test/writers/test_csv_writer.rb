require 'minitest/autorun'
require './lib/common/container.rb'
require './lib/common/container_list.rb'
require './lib/writers/csv_writer.rb'

class TestCsvWriter
  CONFIGURATION_FILE = 'test/writers/files/config/csv_reader_without_header.yml'
  EXPECTED_DATA_FILENAME = 'test/writers/files/data/expected_csv_writer.csv'
  DATA_FILENAME = 'test/writers/files/data/csv_writer.csv'
  FIELDS = %w('id', 'first_name', 'last_name')

  FIRST_RECORD =%w('1', 'Miquel', 'Oliete')
  SECOND_RECORD =%w('2', 'Emili', 'Parreño')
  THIRD_RECORD =%w('3', 'Andres', 'Cirujeda')
  FOURTH_RECORD =%w('4', 'Xavier', 'Noria')

  def test_generated_file
    container_list = Container::ContainerList.new
    container_list << create_container(fields, FIRST_RECORD)
    container_list << create_container(fields, SECOND_RECORD)
    container_list << create_container(fields, THIRD_RECORD)
    container_list << create_container(fields, FOURTH_RECORD)

    csv_writer = CsvWriter.new(CONFIGURATION_FILE)
    csv_writer.write(DATA_FILENAME, container_list)

     assert_equal File.read(EXPECTED_DATA_FILENAME), File.read(DATA_FILENAME)
  end


  private

  def create_container(fields, values)
    container = Container::Container.new(FIELDS)
    (0...fields.length).each do |i|
      container.send("#{fields[i]}=",values[i])
    end

    container
  end
end