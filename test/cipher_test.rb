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
                encryption: "keder ohulw",
                key: "02715",
                date: "040895"
               }

    assert_equal expected, cipher.encrypt("hello world", "02715", "040895")
  end

  def test_it_can_create_an_offset
    cipher = Cipher.new

    assert_equal ['4', '7', '2', '1'], cipher.create_offset('180689')
  end

  def test_it_can_create_keys
    cipher = Cipher.new

    cipher.create_keys('02715')

    assert_equal '02', cipher.a_key
    assert_equal '27', cipher.b_key
    assert_equal '71', cipher.c_key
    assert_equal '15', cipher.d_key
  end
end
