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
  @message_end = "..end.."
  @range = supported_characters.count
  @key_found = []

  def self.temp_crack_key(source_file, date)
    count = index = 0
    message = read_file(source_file)
    last_characters = message.gsub("\n", "")[-7..-1]
    start = -((message.length % 4) + 4)
    finish = (start + 3)
    offset = offset_keys(date)
    start_point = (message.length % 4) + 1
    offset = offset.rotate(start_point)
    while @key_found.length < last_characters.length
      @range.times.collect do |key|
        index = 0 if index == offset.length
        if encrypt_letter(last_characters[count], -(offset[index]+key)) == @message_end[count]
          @key_found << key
          key = 0, count +=1
          break
        end
      end
      index +=1
    end
    @key_found[start..finish].collect do |k|
      k = k < 10 ? (k.to_s).insert(0, "0") : k.to_s
    end
  end

  def self.crack_key(key, original_temp_key)
    left_index = key[@index][-1]
    right_index = key[@index.next][0]
    if (left_index != right_index) && (key[@index.next].to_i).between?(1, 60)
        key[@index.next] = (key[@index.next].to_i + 39).to_s
        crack_key(key, original_temp_key)
    elsif validate_left_and_right_indices(key)
        key = key.join
        cracked_key = key[0..1] + key[4..5] + key[-1]
        return cracked_key
    elsif left_index == right_index
        @index +=1
        crack_key(key, original_temp_key)
    elsif (left_index != right_index) && (key[@index].to_i).between?(1,60)
        key[@index.next] = original_temp_key[@index.next]
        key[@index] = (key[@index].to_i + 39).to_s
        crack_key(key, original_temp_key)
    end
  end

  def self.create_crack_file(source_file, destination_file, key, date)
    message = read_file(source_file)
    write_file destination_file, decrypt(message, key, date)
    puts "Created cracked file '#{destination_file}' with key #{key} and date #{date}"
  end

  if ARGV.length == 3
    files = ARGV.each { |file| file }
    temp = temp_crack_key(ARGV[0], ARGV[2])
    key = crack_key(temp, temp.dup)
    create_crack_file(ARGV[0], ARGV[1], key, ARGV[2])
  else
    puts "Please provide three text files, One with the message and One for encryption"
  end

end
