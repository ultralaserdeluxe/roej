import sys
import Image

def map_to_less_bits(number, bits):
    """"Map a number from 0 - 255 to 0 - 2^bits. """
    return int((number / 256.) * (2**bits))

def to_8_bit(number):
    """Convert a tuple (r, g, b) to binary string RRRGGGBB.

    r, g, b are values on the interval 0 - 255.
    """

    r, g, b = number
    r = map_to_less_bits(r, 3)
    g = map_to_less_bits(g, 3)
    b = map_to_less_bits(b, 2)
    r = bin(r)[2:].zfill(3)
    g = bin(g)[2:].zfill(3)
    b = bin(b)[2:].zfill(2)
    return r + g + b

if __name__ == "__main__":
    im =  Image.open(sys.argv[1])
    im = im.convert()
    binary_numbers =  map(to_8_bit, list(im.getdata()))

    print "("

    printed = 0
    for binary_number in binary_numbers:
        print "\"" + binary_number + "\"" + ",",
        printed = printed + 1

        # Output 16 values at a time.
        if printed % 16 == 0: print

    print ")"
