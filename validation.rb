module Validation
  def check_file?(file)
    validation= File.exist? file
  end

  def key_is_valid?(key)
    key.to_i.between?(10000, 99999)
  end

  def date_is_valid?(date)
    day = date[0..1].to_i
    month = date[2..3].to_i
    day.between?(1,31) && month.between?(1,12)
  end

  def validate_left_and_right_indices(key)
    (key[0][-1] == key[0.next][0]) && (key[1][-1] == key[1.next][0]) && (key[2][-1] == key[2.next][0])
  end
end
