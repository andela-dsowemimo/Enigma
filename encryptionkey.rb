module EncryptionKey
  def supported_characters
    ("a".."z").to_a + ("0".."9").to_a + [" ", ".", ","]
  end

  def cipher(rotation)
    rotated_characters = supported_characters.rotate(rotation)
    Hash[supported_characters.zip(rotated_characters)]
  end

  def encrypt_letter(letter, rotation)
    cipher_for_rotation = cipher(rotation)
    cipher_for_rotation[letter]
  end

  def rotation_keys(key)
    count = 0
    keys =[]
    key = key.to_s
    while count < key.length-1
      keys << (key[count..count+1]).to_i
      count+=1
    end
    keys
  end

  def offset_keys(date)
    date = date.to_i
    date *= date
    date= date.to_s[-4..-1].split("")
    date.collect {|d| d.to_i}
  end

  def encryption_key(key, date)
    encryption_key = []
    encryption_key << rotation_keys(key)
    encryption_key << offset_keys(date)
    encryption_key = encryption_key.transpose.map {|x| x.reduce(:+)}
  end

  def generate_key_and_date
    day = prepend_with_zero rand(1..31).to_s
    month = prepend_with_zero rand(1..12).to_s
    year = prepend_with_zero rand(1..99).to_s
    date = day + month + year
    keys = [rand(11111..99999), date]
  end

  def prepend_with_zero(number)
    number.insert(0, "0") if number.to_i < 10
    number
  end
end
