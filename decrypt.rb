require_relative "encryptionkey.rb"
require_relative "fileworker.rb"
require_relative "decryption.rb"
require_relative "validation.rb"

class Decrypt
  extend EncryptionKey
  extend FileWorker
  extend Decryption
  extend Validation

  def self.decrypt_file(source_file, destination_file, key, date)
    print_failure_message unless File.exist? source_file
    return unless check_file?(source_file)
    if key_is_valid?(key) && date_is_valid?(date)
      message = read_file(source_file)
      decrypted_message = decrypt(message, key, date)
      write_file(destination_file, decrypted_message)
      print_success_message(destination_file, [key, date])
    else
      puts "Please make sure your key is 5 digits and date(DDMMYY) is between '010100' to '311299'"
    end
  end

  if ARGV.length == 4
    args = ARGV.each { |file| file }
    decrypt_file(ARGV[0], ARGV[1], ARGV[2], ARGV[3])
  else
    puts "Please provide encrypted file, file to write decrypted message, 5 digits key and date(DDMMYY)"
  end
end
