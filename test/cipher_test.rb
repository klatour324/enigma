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
end
