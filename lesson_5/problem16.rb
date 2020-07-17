# method that returns one UUID when called with no parameters
# UUID - 32 hexadecimal characters, 8-4-4-4-12, represented as string
# ex: "f65c57f6-a6aa-17a8-faa1-a67f2dc9fa91"
# hexidemical charcters: 123456789abcedf (15 total possible characters)

HEX = '123456789abcedf'

def random_uuid
  hex_chars = []

  32.times do
    hex_chars << HEX[rand(15)]
  end

  "#{hex_chars[0, 8].join('')}-#{hex_chars[8, 4].join('')}-#{hex_chars[12, 4].join('')}-#{hex_chars[16, 4].join('')}-#{hex_chars[20, 12].join('')}"
end

puts random_uuid
