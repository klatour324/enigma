require './lib/key'
require './lib/offset'
require './lib/alphabet_actions'
require './lib/cipherable'

class Enigma
  include AlphabetActions
  include Cipherable

  attr_reader :shifts

  def initialize
    @shifts = nil
  end

  def make_shifts(keys, offsets)
    a_shift = keys[0].to_i + offsets[0].to_i
    b_shift = keys[1].to_i + offsets[1].to_i
    c_shift = keys[2].to_i + offsets[2].to_i
    d_shift = keys[3].to_i + offsets[3].to_i
    @shifts  = [a_shift, b_shift, c_shift, d_shift]
  end

  def retrieve_shift(index, direction)
    (@shifts[index % @shifts.length]) * direction
  end

  def encode(message)
    create_code(message, 1)
  end

  def decode(encrypted_message)
    create_code(encrypted_message, -1)
  end

  def create_code(secret_message, direction)
    secret_message.downcase.split('').each_with_index.reduce('') do |memo, (char, index)|
      retrieve_shift(index, direction)
      if location_of(char).nil?
        memo += char
      else
        scrambled_alphabet = rotate_alphabet(index, direction)
        new_character = scrambled_alphabet[location_of(char)]
        memo += new_character
      end
    end
  end
end
