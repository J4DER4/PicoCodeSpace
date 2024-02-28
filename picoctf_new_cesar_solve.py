encoded_flag = 'dcebcmebecamcmanaedbacdaanafagapdaaoabaaafdbapdpaaapadanandcafaadbdaapdpandcac'

ALPHABET = 'abcdefghijklmnop'
LOWERCASE_OFFSET = ord("a")

def shift(c, k):
	t1 = ord(c) - LOWERCASE_OFFSET
	t2 = ord(k) - LOWERCASE_OFFSET
	return ALPHABET[(t1 - t2) % len(ALPHABET)]

def b16_decode(enc):
	res = [ALPHABET.index(c) for c in enc]
	return (res[0] << 4 | res[1])

def decrypt(encrypted_flag):
	# for every possible key
	for alpha in ALPHABET:
		# for single key unshift the encrypted flag
		splitted_ecnrypted_flag = ''.join([shift(c, alpha) for c in encrypted_flag])
		# split the encrypted flag into pairs of two
		splitted_ecnrypted_flag = [splitted_ecnrypted_flag[i:i+2] for i in range(0, len(encrypted_flag), 2)]
		# decode the unsifted pairs
		flag = ''.join([chr(b16_decode(pair)) for pair in splitted_ecnrypted_flag])  # Convert the result of b16_decode to a character
		# known plaintext et_tu? in flag 
		if 'et_tu?' in flag :
			print(' Key: ', alpha, 'with length: ', len(flag), ' Flag: picoCTF{', flag.rstrip(), '}', sep='')

decrypt(encoded_flag)
