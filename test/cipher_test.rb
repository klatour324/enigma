require './test/test_helper'
require './lib/cipher'

class CipherTest < Minitest::Test
  def test_it_exists
    cipher = Cipher.new

    assert_instance_of Cipher, cipher
  end

  def test_it_can_encrypt_a_message_with_given_key_and_date
    cipher = Cipher.new

    expected = {
                encryption: 'keder ohulw',
                key: '02715',
                date: '040895'
               }

    assert_equal expected, cipher.encrypt('hello world', '02715', '040895')
  end

  def test_it_can_create_an_offset
    cipher = Cipher.new

    cipher.create_offset('180689')

    assert_equal ['4', '7', '2', '1'], cipher.offset
  end

  def test_it_can_create_keys
    cipher = Cipher.new

    cipher.create_keys('02715')

    assert_equal 2, cipher.a_key
    assert_equal 27, cipher.b_key
    assert_equal 71, cipher.c_key
    assert_equal 15, cipher.d_key
  end

  def test_it_can_make_shifts
    cipher = Cipher.new
    a_shift = 3
    b_shift = 27
    c_shift = 73
    d_shift = 20

    cipher.create_offset('040895')
    cipher.create_keys('02715')
    cipher.make_shifts

    assert_equal 3, cipher.a_shift
    assert_equal 27, cipher.b_shift
    assert_equal 73, cipher.c_shift
    assert_equal 20, cipher.d_shift
  end
end
