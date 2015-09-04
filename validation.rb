module Validation
  def is_file?(file)
    validation= File.exist? file
    error= "File Does not Exist!!"
    puts error unless validation
    validation
  end

  def is_valid_key?(key)
    key.to_i.between?(10000, 99999)
  end

  def is_valid_date?(date)
    day = date[0..1].to_i
    month = date[2..3].to_i
    day.between?(1,31) && month.between?(1,12)
  end
end
