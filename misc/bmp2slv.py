import sys
import Image

def to_binary(number):
    return bin(number)[2:]

if __name__ == "__main__":
    im =  Image.open(sys.argv[1])
    binary_numbers =  map(to_binary, list(im.getdata()))
    print "(",
    for binary_number in binary_numbers:
        print "\"" + binary_number + "\"" + ",",
    print ")"
