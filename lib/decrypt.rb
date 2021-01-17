require './lib/enigma'

enigma = Enigma.new

handle = File.open(ARGV[0], 'r')

encrypted_message = handle.read

handle.close

decrypted = enigma.decrypt(encrypted_message, ARGV[2], ARGV[3])

writer = File.open(ARGV[1], 'w')

writer.write(decrypted[:decryption])

writer.close

puts "Created '#{ARGV[1]}' with the key #{decrypted[:key]} and date #{decrypted[:date]}"
