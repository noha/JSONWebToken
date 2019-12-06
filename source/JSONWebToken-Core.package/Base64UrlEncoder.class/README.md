I am encoder/decoder for base 64 using an alphabet that's URL and filename safe according to https://tools.ietf.org/html/rfc4648#page-5.

Base64 encoding is a technique to encode binary data as a string of characters that can be safely transported over various protocols. 
Basically, every 3 bytes are encoded using 4 characters from an alphabet of 64. Each encoded character represents 6 bits.

