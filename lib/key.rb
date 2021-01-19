class Key
  attr_reader :key

  def initialize(key)
    @key = key ||= generate_key
  end

  def create_keys
    split_key = key.split('')

    a_key = (split_key[0] + split_key[1])
    b_key = (split_key[1] + split_key[2])
    c_key = (split_key[2] + split_key[3])
    d_key = (split_key[3] + split_key[4])

    [a_key, b_key, c_key, d_key]
  end

  def generate_key
    rand(9999).to_s.rjust(5, '0')
  end
end
