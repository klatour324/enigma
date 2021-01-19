module Cipherable

  def encrypt(message, key = nil, date = nil)
    offset = Offset.new(date)
    key_component = Key.new(key)

    make_shifts(key_component.create_keys, offset.create_offsets)

    encrypted_message = encode(message)

    {encryption: encrypted_message, key: key_component.key, date: offset.date}
  end

  def decrypt(encrypted_message, key, date = nil)
    offset = Offset.new(date)
    key_component = Key.new(key)

    make_shifts(key_component.create_keys, offset.create_offsets)

    decrypted_message = decode(encrypted_message)

    {decryption: decrypted_message, key: key_component.key, date: offset.date}
  end
end
