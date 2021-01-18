module AlphabetActions
  ALPHABET = ('a'..'z').to_a << ' '

  def location_of(char)
    ALPHABET.index(char)
  end

  def rotate_alphabet(index, direction)
    ALPHABET.rotate(retrieve_shift(index, direction))
  end
end
