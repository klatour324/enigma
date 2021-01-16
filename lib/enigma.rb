require 'date'

class Enigma

  def encrypt(message, key, date)
    {
      encryption: message,
      key: key,
      date: date
    }
  end
end

#  offset_conversion = ((date.to_i) ** 2).to_s
#  offset = offset_conversion.split('').last(4)
#
#  split_key = key.split('')
#  a_key = split_key[0] + split_key[1]
#  b_key = split_key[1] + split_key[2]
#  c_key = split_key[2] + split_key[3]
#  d_key = split_key[3] + split_key[4]
#
#  a_shift = (a_key.to_i) + (offset[0].to_i)
#  b_shift = b_key.to_i + offset[1].to_i
#  c_shift = c_key.to_i + offset[2].to_i
#  d_shift = d_key.to_i + offset[3].to_i
#
# rotor = Hash[]
#
# message.downcase.chars.reduce("") do |memo, char|
#   char
# split_key = key.split("")
# key.each_with_index() do|key|
#     require "pry"; binding.pry
# end
# rotor = Hash[ALPHABET.zip(ALPHABET.rotate()]
# puts rotor
# letter_map = Hash[]
# ALPHABET = ('a'..'z').to_a << ' '
