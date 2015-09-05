require "spec_helper"
require "./encrypt"
require "./encryptionkey"
require "./fileworker"
require "./encryption"

describe Encrypt do
  it "should return an encrypted file" do
    source_file = "secrets.txt"
    destination_file = "secrets_encrypted.txt"
    Encrypt.encrypt_file(source_file, destination_file)
    expect(File.exist? destination_file).to eq(true)
  end

  it "should return an encrypted letter" do
    letter = "x"
    rotation = 1
    expect(Encrypt.encrypt_letter(letter, rotation)).to eq("y")
  end

  it "should return a key array" do
    key = 58273
    expect(Encrypt.rotation_keys(key).count).to eq 4
    expect(Encrypt.rotation_keys(key)).to eq [58, 82, 27, 73]
  end

  it "should return an offset key array" do
    date = "231299"
    expect(Encrypt.offset_keys(date).count).to eq 4
    expect(Encrypt.offset_keys date).to eq [7, 4, 0, 1]
  end

  it "should return an encryption key" do
    key = 14565
    date = "231299"
    expect(Encrypt.encryption_key(key, date)).to eq [21, 49, 56, 66]
  end

  it "should return unsupported letters" do
    message= "@!#$%*()"
    key = 12345
    date = "121290"
    expect(Encrypt.encrypt(message, key, date)).to eq message
  end
end
