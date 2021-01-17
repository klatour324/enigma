class Cipher
  ALPHABET = ('a'..'z').to_a << ' '

  attr_reader :a_key,
              :b_key,
              :c_key,
              :d_key,
              :offset,
              :a_shift,
              :b_shift,
              :c_shift,
              :d_shift,
              :shifts

  def initialize
    @a_key    = nil
    @b_key    = nil
    @c_key    = nil
    @d_key    = nil
    @offset   = nil
    @a_shift  = nil
    @b_shift  = nil
    @c_shift  = nil
    @d_shift  = nil
    @shifts   = nil
  end

  def make_shifts
    @a_shift = a_key + offset[0].to_i
    @b_shift = b_key + offset[1].to_i
    @c_shift = c_key + offset[2].to_i
    @d_shift = d_key + offset[3].to_i
    @shifts  = [a_shift, b_shift, c_shift, d_shift]
  end

  def create_keys(key)
    split_key = key.split('')

    @a_key = (split_key[0] + split_key[1]).to_i
    @b_key = (split_key[1] + split_key[2]).to_i
    @c_key = (split_key[2] + split_key[3]).to_i
    @d_key = (split_key[3] + split_key[4]).to_i
  end

  def create_offset(date)
    @offset = ((date.to_i) ** 2).to_s.split('').last(4)
  end

  def encrypt(message, key, date)
    create_offset(date)
    create_keys(key)
    make_shifts

    encrypted_message = message.downcase.split('').each_with_index.reduce("") do |memo, (char, index)|
      shift_index = index % make_shifts.length
      shift = make_shifts[shift_index]
      character_index = ALPHABET.index(char)
      rotated_alphabet = ALPHABET.rotate(shift)
      new_character = rotated_alphabet[character_index]
      memo += new_character
    end
    Hash[encryption: encrypted_message, key: key, date: date]
  end

  def decrypt(encrypted_message, key, date)
    create_offset(date)
    create_keys(key)
    make_shifts

    decrypted_message = encrypted_message.downcase.split('').each_with_index.reduce("") do |memo, (char, index)|
      shift_index = index % shifts.length
      shift = -(shifts[shift_index])
      character_index = ALPHABET.index(char)
      rotated_alphabet = ALPHABET.rotate(shift)
      new_character = rotated_alphabet[character_index]
      memo += new_character
    end
    Hash[decryption: decrypted_message, key: key, date: date]
  end
end
