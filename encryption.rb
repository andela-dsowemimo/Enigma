module Encryption
  def encrypt(message, key, date)
    index = -1
    message = message.gsub("\n", "")
    letters = message.downcase.split("")
    rotation = encryption_key(key, date)
    encrypted_message = letters.collect do |letter|
      index += 1
      index = 0 if index == 4
      encrypt_letter(letter, rotation[index])
    end
    encrypted_message.join
  end

end
