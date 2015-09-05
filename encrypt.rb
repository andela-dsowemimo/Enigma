require_relative "encryptionkey.rb"
require_relative "fileworker.rb"
require_relative "encryption.rb"
require_relative "validation.rb"

class Encrypt
  extend EncryptionKey
  extend FileWorker
  extend Encryption
  extend Validation

    def self.encrypt_file(source_file, destination_file)
      print_failure_message unless File.exist? source_file
      return unless check_file?(source_file)
      message = read_file(source_file)
      keys= generate_key_and_date
      encrypted_message = encrypt(message, keys[0], keys[1])
      destination_file = change_filename(destination_file) if check_file?(destination_file)
      write_file(destination_file, encrypted_message)
      print_success_message(destination_file, keys)
    end

    if ARGV.length == 2
      files = ARGV.each { |file| file }
      encrypt_file(ARGV[0], ARGV[1])
    else
      puts "Please provide two text files, One with the message and One for encryption"
    end
end
