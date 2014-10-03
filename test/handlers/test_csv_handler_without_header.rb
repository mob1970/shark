require 'minitest/autorun'
require './lib/handlers/csv_handler.rb'

class TestCsvHandlerWithoutHeader < Minitest::Unit::TestCase
  TECHNOLOGY_REFERENCE = 'test/handlers/files/data/'

	CONFIGURATION_FILE = 'test/handlers/files/config/csv_handler_without_header.yml'
	DATA_FILE = 'csv_handler_without_header.csv'

	def setup
    technology = MiniTest::Mock.new
    technology.expect(:reference, TECHNOLOGY_REFERENCE)
		csv_handler = Handlers::CsvHandler.new(CONFIGURATION_FILE, technology)
		@information = csv_handler.read(DATA_FILE)
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
