require "spec_helper"
require "./decrypt"
require "./encryptionkey"
require "./fileworker"
require "./decryption"

describe Decrypt do
  it "should return a decrypted file" do
    source_file = "secrets_encrypted.txt"
    destination_file = "secrets_decrypted.txt"
    key = 50653
    date = "220985"
    Decrypt.decrypt_file(source_file, destination_file, key, date)
    expect(File.exist? destination_file).to eq true
  end

  it "should return a decrypted message" do
    message = Decrypt.read_file "secrets_encrypted.txt"
    key = 50653
    date = "220985"
    decrypted_message =Decrypt.decrypt(message, key, date)
    expect(decrypted_message).to eq Decrypt.read_file("secrets_decrypted.txt")
  end

  it "should retun a valid offset key" do
    date = "220985"
    expect(Decrypt.offset_keys(date)).to eq [0,2,2,5]
  end

  it "should return invalid date" do
    date = "124532"
    expect(Decrypt.date_is_valid? date).to eq false
  end
end
