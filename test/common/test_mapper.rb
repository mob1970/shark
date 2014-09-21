require 'minitest/autorun'
require './lib/common/mapper.rb'
require './lib/common/mapping.rb'

class TestMapper < Minitest::Unit::TestCase
	SOURCE_FIELD_1 = 'nombre'
	TARGET_FIELD_1 = 'name'

	SOURCE_FIELD_2 = 'primer_apellido'
	TARGET_FIELD_2 = 'first_name'

	def setup()
		@mapper = Common::Container::Mapper.new()
	       	@mapper << Common::Container::Mapping.new(SOURCE_FIELD_1, TARGET_FIELD_1)
	       	@mapper << Common::Container::Mapping.new(SOURCE_FIELD_2, TARGET_FIELD_2)
	end

	def test_source_first_mapping
		assert_equal SOURCE_FIELD_1, @mapper[0].source
	end

	def test_target_first_mapping
		assert_equal TARGET_FIELD_1, @mapper[0].target
	end

	def test_source_last_mapping
		assert_equal SOURCE_FIELD_2, @mapper[-1].source
	end

	def test_target_last_mapping
		assert_equal TARGET_FIELD_2, @mapper[-1].target
	end
end
