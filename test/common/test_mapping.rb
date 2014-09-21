require 'minitest/autorun'
require './lib/common/mapping.rb'

class TestMapping < Minitest::Unit::TestCase
	SOURCE_FIELD = 'nombre'
	TARGET_FIELD = 'name'

	def setup()
		@mapping = Common::Container::Mapping.new(SOURCE_FIELD, TARGET_FIELD)
	end

	def test_source_field()
		assert_equal SOURCE_FIELD, @mapping.source
	end

	def test_target_field()
		assert_equal TARGET_FIELD, @mapping.target
	end
end
