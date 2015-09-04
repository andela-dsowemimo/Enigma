module Decryption
  def decrypt(message, key, date)
    index = -1
    letters = message.downcase.split("")
    rotation = encryption_key(key, date)
    decrypted_message = letters.collect do |letter|
      index += 1
      index = 0 if index == 4
      encrypt_letter(letter, -(rotation[index]))
    end
    decrypted_message.join
  end
end
