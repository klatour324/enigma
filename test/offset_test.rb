require './test/test_helper'
require './lib/offset'

class OffsetTest < Minitest::Test
  def test_it_exists
    offset = Offset.new('040895')

    assert_instance_of Offset, offset
  end

  def test_it_can_create_an_offset_with_given_offset
    offset = Offset.new('040895')

    assert_equal ['1', '0', '2', '5'], offset.create_offsets
  end

  def test_it_generate_offset_when_date_is_not_given
    offset = Offset.new(nil)
    Date.stubs(:today).returns(Date.parse('2021-01-17'))

    assert_equal ['4', '6', '4', '1'], offset.create_offsets
  end
end
