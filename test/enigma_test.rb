require './test/test_helper'
require './lib/enigma'

class EnigmaTest < Minitest::Test
  def test_it_exists
    enigma = Enigma.new

    assert_instance_of Enigma, enigma
  end

  def test_it_can_encrypt_a_message_with_given_key_and_date
    enigma = Enigma.new

    expected = {
                encryption: 'keder ohulw',
                key: '02715',
                date: '040895'
               }

    assert_equal expected, enigma.encrypt('hello world', '02715', '040895')
  end

  def test_it_can_create_an_offset
    enigma = Enigma.new

    enigma.create_offset('180689')

    assert_equal ['4', '7', '2', '1'], enigma.offset
  end

  def test_it_can_create_keys
    enigma = Enigma.new

    enigma.create_keys('02715')

    assert_equal 2, enigma.a_key
    assert_equal 27, enigma.b_key
    assert_equal 71, enigma.c_key
    assert_equal 15, enigma.d_key
  end

  def test_it_can_make_shifts
    enigma = Enigma.new
    a_shift = 3
    b_shift = 27
    c_shift = 73
    d_shift = 20

    enigma.create_offset('040895')
    enigma.create_keys('02715')
    enigma.make_shifts

    assert_equal 3, enigma.a_shift
    assert_equal 27, enigma.b_shift
    assert_equal 73, enigma.c_shift
    assert_equal 20, enigma.d_shift
  end

  def test_it_can_decrypt_a_message_with_given_key_and_date
    enigma = Enigma.new

    expected = {
                decryption: 'hello world',
                key: '02715',
                date: '040895'
               }

    assert_equal expected, enigma.decrypt('keder ohulw', '02715', '040895')
  end

  def test_it_can_encrypt_messages_with_non_characters
    enigma = Enigma.new

    expected = {
      encryption: 'keder ohulw!',
      key: '02715',
      date: '040895'
    }

    assert_equal expected, enigma.encrypt('hello world!', '02715', '040895')
  end

  def test_it_can_decrypt_messages_with_non_characters
    enigma = Enigma.new

    expected = {
      decryption: 'hello world1',
      key: '02715',
      date: '040895'
    }

    assert_equal expected, enigma.decrypt('keder ohulw1', '02715', '040895')
  end


  def test_location_of_char
    enigma = Enigma.new

    assert_equal 0, enigma.location_of('a')
  end

  def test_it_can_retrieve_shift
    enigma = Enigma.new

    enigma.create_keys('02715')
    enigma.create_offset('040895')

    assert_equal 27, enigma.retrieve_shift(1, 1)
    assert_equal -73, enigma.retrieve_shift(2, -1)
  end

  def test_it_rotates_alphabet
    enigma = Enigma.new

    enigma.create_keys('02715')
    enigma.create_offset('040895')

    assert_equal ["d", "e", "f", "g", "h", "i",
                  "j", "k", "l","m", "n", "o",
                  "p", "q", "r", "s", "t", "u",
                  "v", "w", "x", "y", "z", " ",
                  "a", "b", "c"], enigma.rotate_alphabet(0, 1)


    assert_equal ["y", "z", " ", "a", "b", "c",
                  "d", "e", "f","g", "h", "i",
                  "j", "k", "l", "m", "n", "o",
                  "p", "q", "r", "s", "t", "u",
                  "v", "w", "x"], enigma.rotate_alphabet(0, -1)

  end

  def test_it_makes_code
    enigma = Enigma.new

    enigma.create_keys('02715')
    enigma.create_offset('040895')
    enigma.location_of('l')
    enigma.retrieve_shift(2, 1)
    enigma.rotate_alphabet(2, 1)

    assert_equal 'keder', enigma.code('hello', 1)
  end

  def test_it_encodes_when_direction_is_positive
    enigma = Enigma.new

    enigma.create_keys('02715')
    enigma.create_offset('040895')
    enigma.location_of('t')
    enigma.retrieve_shift(2, 1)
    enigma.rotate_alphabet(2, 1)

    assert_equal 'w', enigma.encode('t')
  end

  def test_it_can_translate_when_direction_is_negative
    enigma = Enigma.new

    enigma.create_keys('02715')
    enigma.create_offset('040895')
    enigma.location_of('a')
    enigma.retrieve_shift(2, -1)
    enigma.rotate_alphabet(2, -1)

    assert_equal 'y', enigma.translate('a')
    assert_equal 'words', enigma.translate('zojxv')
  end

  def test_it_encrypts_a_message_using_todays_date
    enigma = Enigma.new
    Time.stubs(:now).returns(Time.parse('2021-01-17'))

    expected = {
                encryption: 'nkfaufqdxry',
                key: '02715',
                date: '170121'
               }

    assert_equal expected, enigma.encrypt('hello world', '02715')
  end

  def test_it_decrypts_a_message_using_todays_date
    enigma = Enigma.new

    Time.stubs(:now).returns(Time.parse('2021-01-17'))

    expected = {
                decryption: 'hello world',
                key: '02715',
                date: '170121'
               }

    assert_equal expected, enigma.decrypt('nkfaufqdxry', '02715')
  end

  def test_it_generates_a_random_key_and_uses_todays_date
    enigma = Enigma.new

    Time.stubs(:now).returns(Time.parse('2021-01-17'))
    enigma.stubs(:rand).returns(1234)

    expected = {
                encryption: 'mwlttrwwwcd',
                key: '01234',
                date: '170121'
               }

    assert_equal expected, enigma.encrypt('hello world')
  end

  def test_it_generates_a_key
    enigma = Enigma.new

    Time.stubs(:now).returns(Time.parse('2021-01-17'))
    enigma.stubs(:rand).returns(1234)

    expected = {
                encryption: 'mwlttrwwwcd',
                key: '01234',
                date: '170121'
               }

    assert_equal expected[:key], enigma.generate_key
  end
end
