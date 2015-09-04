module Encryption
  def encrypt(message, key, date)
    index = 0
    message = message.gsub("\n", "")
    letters = message.downcase.split("")
    rotation = encryption_key(key, date)
    encrypted_message = letters.collect do |letter|
      index = 0 if index == 4
      if supported_characters.include? letter
        letter = encrypt_letter(letter, (rotation[index]))
        index +=1
      end
      letter
    end
    encrypted_message.join
  end

end
