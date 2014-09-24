require 'minitest/autorun'
require './lib/common/container.rb'
require './lib/common/container_list.rb'
require './lib/writers/delimited_writer'

class TestDelimitedWriter < MiniTest::Unit::TestCase
  CONFIGURATION_FILE = 'test/writers/files/config/delimited_writer.yml'
  EXPECTED_DATA_FILENAME = 'test/writers/files/data/expected_delimited_writer.txt'
  DATA_FILENAME = 'test/writers/files/data/delimited_writer.txt'
  FIELDS = %w(id first_name last_name)

  FIRST_RECORD = %w(1 Miquel Oliete)
  SECOND_RECORD = %w(2 Emili Parreño)
  THIRD_RECORD = %w(3 Andres Cirujeda)
  FOURTH_RECORD = %w(4 Xavier Noria)


  def test_generated_file
    container_list = Common::Container::ContainerList.new
    container_list << create_container(FIELDS, FIRST_RECORD)
    container_list << create_container(FIELDS, SECOND_RECORD)
    container_list << create_container(FIELDS, THIRD_RECORD)
    container_list << create_container(FIELDS, FOURTH_RECORD)

    delimited_writer = Writers::DelimitedWriter.new(CONFIGURATION_FILE)
    delimited_writer.write(DATA_FILENAME, container_list)

    assert_equal File.read(EXPECTED_DATA_FILENAME), File.read(DATA_FILENAME)
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