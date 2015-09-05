module Decryption
  def decrypt(message, key, date)
    index = -1
    letters = message.downcase.split("")
    rotation = encryption_key(key, date)
    decrypted_message = letters.collect do |letter|
      index += 1
      index = 0 if index == 4
      letter = supported_characters.include?(letter) ? encrypt_letter(letter,-(rotation[index])) : letter
    end
    decrypted_message.join
  end
end
