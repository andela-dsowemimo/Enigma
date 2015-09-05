Enigma

Enigma is an Encryption Tool.
Encrypt a secret message using a random key and date.
The encrypted message can be decrypted using the same key and date.
Decipher a message using just the date by cracking it.

Encrypt message
ruby encrypt.rb secrets.txt encrypted.txt

Decrypt message
ruby decrypt.rb encrypted.txt decrypted.txt 90231 "211299"

Crack message
ruby encrypted.txt cracked.txt "211299"
