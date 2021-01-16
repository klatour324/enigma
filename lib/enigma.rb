require 'date'

class Enigma
  ALPHABET = ('a'..'z').to_a << ' '


  def encrypt(message, key, date)
   offset_conversion = ((date.to_i) ** 2).to_s
   offset = offset_conversion.split('').last(4)

   split_key = key.split('')
   a_key = split_key[0] + split_key[1]
   b_key = split_key[1] + split_key[2]
   c_key = split_key[2] + split_key[3]
   d_key = split_key[3] + split_key[4]

   a_shift = (a_key.to_i) + (offset[0].to_i)
   b_shift = b_key.to_i + offset[1].to_i
   c_shift = c_key.to_i + offset[2].to_i
   d_shift = d_key.to_i + offset[3].to_i


   shifts = [a_shift, b_shift, c_shift, d_shift]

    encrypted_message = message.downcase.split('').each_with_index.reduce("") do |memo, (char, index)|
      shift_index = index % shifts.length
      shift = shifts[shift_index]
      character_index = ALPHABET.index(char)
      rotated_alphabet = ALPHABET.rotate(shift)
      new_character = rotated_alphabet[character_index]
      memo += new_character
    end

    {
      encryption: encrypted_message,
      key: key,
      date: date
    }
  end
end
