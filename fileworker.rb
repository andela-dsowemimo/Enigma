module FileWorker
  def write_file(filename, message)
    filename = File.open(filename, "w")
    filename.write(message)
    filename.close
  end

  def read_file(filename)
    filename = File.open(filename, "r")
    message = filename.read
    filename.close
    message
  end

  def change_filename(filename)
    new_filename = filename.dup
    new_filename.insert new_filename.length-4, rand(1..10000).to_s
  end

  def print_success_message(destination_file, keys)
    puts "Created '#{destination_file}' with the key #{keys[0]} and date #{keys[1]}"
  end
end
