require './test/test_helper'
require './lib/key'

class KeyTest < Minitest::Test
  def test_it_exists
    key = Key.new('02715')

    assert_instance_of Key, key
  end

  def test_it_can_create_keys_when_given_a_key
    key = Key.new('02715')

    assert_equal ['02', '27', '71', '15'], key.create_keys
  end

  def test_it_generates_a_five_digit_key_when_no_key_is_given
    key = Key.new(nil)

    key.stubs(:rand).returns(1234)

    expected = {
                encryption: 'mwlttrwwwcd',
                key: '01234',
                date: '170121'
               }

    assert_equal expected[:key], key.generate_key
  end
end
