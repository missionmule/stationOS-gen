import os, binascii

uuid = binascii.b2a_hex(os.urandom(2)).decode()

print (uuid)
