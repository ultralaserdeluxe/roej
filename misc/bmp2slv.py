import sys
import Image

def to_binary(number):
    return bin(number)[2:].zfill(8)

if __name__ == "__main__":
    im =  Image.open(sys.argv[1])
    binary_numbers =  map(to_binary, list(im.getdata()))

    printed = 0
    print "("
    for binary_number in binary_numbers:
        print "\"" + binary_number + "\"" + ",",
        printed = printed + 1
        if printed % 16 == 0: print
    print ")"
