require_relative "encryptionkey.rb"
require_relative "fileworker.rb"
require_relative "decryption.rb"
require_relative "validation.rb"

class Crack
  extend EncryptionKey
  extend FileWorker
  extend Decryption
  extend Validation

  @index = 0

  def self.temp_crack_key(source_file, destination_file, date)
    message = read_file(source_file)
    last_characters = message.gsub("\n", "")[-7..-1]
    message_end = "..end.."
    range = supported_characters.count
    key_found = []
    count = key_count = index = 0
    offset = offset_keys(date)
    start_point = (message.length % 4) + 1
    offset = offset.rotate(start_point)
    while key_found.length < last_characters.length
      range.times.collect do |key|
          index = 0 if index == offset.length
          if encrypt_letter(last_characters[count], -(offset[index]+key)) == message_end[count]
            key_found << key
            key = 0, count +=1
            break
          end
      end
          index +=1
    end
    key_found[-4..-1].collect {
      |k|
      k = (k.to_s).insert(0, "0") if k < 10
      k.to_s
    }
  end

  def self.crack_key(key, original_temp_key)
      if (key[@index][-1] != key[@index.next][0]) && (key[@index.next].to_i).between?(1, 60)
          key[@index.next] = (key[@index.next].to_i + 39).to_s
          crack_key(key, original_temp_key)
      elsif (key[0][-1] == key[0.next][0]) && (key[1][-1] == key[1.next][0]) && (key[2][-1] == key[2.next][0])
          key = key.join
          n = key[0..1] + key[4..5] + key[-1]
          return n
      elsif key[@index][-1] == key[@index.next][0]
          key[@index] = key[@index]
          key[@index.next] = key[@index.next]
          @index +=1
          crack_key(key, original_temp_key)
      elsif (key[@index][-1] != key[@index.next][0]) && (key[@index].to_i).between?(1,60)
          key[@index.next] = original_temp_key[@index.next]
          key[@index] = (key[@index].to_i + 39).to_s
          crack_key(key, original_temp_key)
      end
  end

  def self.create_crack_file(source_file, destination_file, key, date)
    message = read_file(source_file)
    write_file destination_file, decrypt(message, key, date)
    puts "Created cracked file #{destination_file} with key #{key} and date #{date}"
  end



  if ARGV.length == 3
    files = ARGV.each { |file| file }
    temp = temp_crack_key(ARGV[0], ARGV[1], ARGV[2])
    key = crack_key(temp, temp.dup)
    create_crack_file(ARGV[0], ARGV[1], key, ARGV[2])
  else
    puts "Please provide three text files, One with the message and One for encryption"
  end

end
