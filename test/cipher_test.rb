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

  def test_it_can_decrypt_a_message_with_given_key_and_date
    cipher = Cipher.new

    expected = {
                decryption: 'hello world',
                key: '02715',
                date: '040895'
               }

    assert_equal expected, cipher.decrypt('keder ohulw', '02715', '040895')
  end

  def test_it_can_encrypt_messages_with_non_characters
    cipher = Cipher.new

    expected = {
      encryption: 'keder ohulw!',
      key: '02715',
      date: '040895'
    }

    assert_equal expected, cipher.encrypt('hello world!', '02715', '040895')
  end

  def test_it_can_decrypt_messages_with_non_characters
    cipher = Cipher.new

    expected = {
      decryption: 'hello world1',
      key: '02715',
      date: '040895'
    }

    assert_equal expected, cipher.decrypt('keder ohulw1', '02715', '040895')
  end


  def test_location_of_char
    cipher = Cipher.new

    assert_equal 0, cipher.location_of('a')
  end

  def test_it_can_retrieve_shift
    cipher = Cipher.new

    cipher.create_keys('02715')
    cipher.create_offset('040895')

    assert_equal 27, cipher.retrieve_shift(1, 1)
    assert_equal -73, cipher.retrieve_shift(2, -1)
  end

  def test_it_rotates_alphabet
    cipher = Cipher.new

    cipher.create_keys('02715')
    cipher.create_offset('040895')

    assert_equal ["d", "e", "f", "g", "h", "i",
                  "j", "k", "l","m", "n", "o",
                  "p", "q", "r", "s", "t", "u",
                  "v", "w", "x", "y", "z", " ",
                  "a", "b", "c"], cipher.rotate_alphabet(0, 1)


    assert_equal ["y", "z", " ", "a", "b", "c",
                  "d", "e", "f","g", "h", "i",
                  "j", "k", "l", "m", "n", "o",
                  "p", "q", "r", "s", "t", "u",
                  "v", "w", "x"], cipher.rotate_alphabet(0, -1)

  end

  def test_it_makes_code
    cipher = Cipher.new

    cipher.create_keys('02715')
    cipher.create_offset('040895')
    cipher.location_of('l')
    cipher.retrieve_shift(2, 1)
    cipher.rotate_alphabet(2, 1)

    assert_equal 'keder', cipher.code('hello', 1)
  end

  def test_it_encodes_when_direction_is_positive
    cipher = Cipher.new

    cipher.create_keys('02715')
    cipher.create_offset('040895')
    cipher.location_of('t')
    cipher.retrieve_shift(2, 1)
    cipher.rotate_alphabet(2, 1)

    assert_equal 'w', cipher.encode('t')
  end

  def test_it_can_translate_when_direction_is_negative
    cipher = Cipher.new

    cipher.create_keys('02715')
    cipher.create_offset('040895')
    cipher.location_of('a')
    cipher.retrieve_shift(2, -1)
    cipher.rotate_alphabet(2, -1)

    assert_equal 'y', cipher.translate('a')
    assert_equal 'words', cipher.translate('zojxv')
  end

  def test_it_encrypts_a_message_using_todays_date
    cipher = Cipher.new
    Time.stubs(:now).returns(Time.parse('2021-01-17'))

    expected = {
                encryption: 'nkfaufqdxry',
                key: '02715',
                date: '170121'
               }

    assert_equal expected, cipher.encrypt('hello world', '02715')
  end

  def test_it_decrypts_a_message_using_todays_date
    cipher = Cipher.new

    Time.stubs(:now).returns(Time.parse('2021-01-17'))

    expected = {
                decryption: 'hello world',
                key: '02715',
                date: '170121'
               }

    assert_equal expected, cipher.decrypt('nkfaufqdxry', '02715')
  end

  def test_it_generates_a_random_key_and_uses_todays_date
    cipher = Cipher.new

    Time.stubs(:now).returns(Time.parse('2021-01-17'))
    cipher.stubs(:rand).returns(1234)

    expected = {
                encryption: 'mwlttrwwwcd',
                key: '01234',
                date: '170121'
               }

    assert_equal expected, cipher.encrypt('hello world')
  end

  def test_it_generates_a_key
    cipher = Cipher.new

    Time.stubs(:now).returns(Time.parse('2021-01-17'))
    cipher.stubs(:rand).returns(1234)

    expected = {
                encryption: 'mwlttrwwwcd',
                key: '01234',
                date: '170121'
               }

    assert_equal expected[:key], cipher.key_generator
  end
end
