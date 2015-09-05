require "./encryptionkey.rb"
require "./fileworker.rb"
require "./decryption.rb"
require "./validation.rb"
require "./crack.rb"

describe Crack do
  it "should return a cracked file" do
    source_file = "secrets_encrypted.txt"
    destination_file = "secrets_cracked.txt"
    date = "220985"
    temp_key = Crack.temp_crack_key(source_file, date)
    key = Crack.crack_key(temp_key,temp_key.dup)
    Crack.create_crack_file(source_file, destination_file, key, date)
    expect(File.exist? destination_file).to eq(true)
  end

  it "should return the same message as decrypted message" do
    decrypted_message = Crack.read_file("secrets_decrypted.txt")
    cracked_message = Crack.read_file("secrets_cracked.txt")
    expect(decrypted_message).to eq(cracked_message)
  end
end
