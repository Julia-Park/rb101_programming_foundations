=begin
write a method that takes a string as argument
return string in reverse order without using built in String#reverse method

Intialize return variable which will contain reversed string
Loop through string backwards and add each letter to new reversed string
- From n being length of string - 1 down to 0, for each n
  - Put the character at position n of of the input string into the reversed string
Return reversed string

=end

def reverse_string(string)
  reversed = ''

  (string.length - 1).downto(0) do |n|
    reversed << string[n]
  end

  reversed
end

# p reverse_string('bottle')
# p reverse_string('rainbows')

=begin
FizzBuzz

Input: 2 integers; Starting number, ending number
Ouput: All numbers between input integers except
- If number is divisible by 3, print "Fizz"
- If number is divisible by 5, print "Buzz"
- If number is divisible by both, print "FizzBuzz" (divisible by 15)
- Separate each number/Fizz/Buzz/FizzBuzz via comma and print on one line
Q: Is return important?

Initalize results variable = empty array
Iterate through numbers between starting and ending integers
  For each iteration, add element to results array based on following conditions: 
  - If number is divisible by 3, "Fizz"
  - If number is divisible by 5, "Buzz"
  - If number is divisible by both, "FizzBuzz" (divisible by 15)
  - Else, number
Print results array joined with commas

=end

def fizzbuzz(start_num, end_num)
  results = []
  start_num.upto(end_num) do |n|
    element = if n % 15 == 0 then
                'FizzBuzz'
              elsif n % 5 == 0 then
                'Buzz'
              elsif n % 3 == 0 then
                'Fizz'
              else
                n
              end

    results << element
  end

  puts results.join(', ')
end

# fizzbuzz(1, 15)

=begin
Input: hash representing a query
Return: subset of PRODUCTS array, based on criteria outlined in input query hash

1. Select elements in PRODUCTS where: (Array#select => array)
  a. Includes the :q string object value within the :name value, case in-sensitive
    (String#match? => true/false)
  b. Its :price value fits into range beween values of :price_min and :price_max,
     inclusive
    (Range#cover?)
2. Return selection

=end
PRODUCTS = [
  { name: "Thinkpad x210", price: 220 }, { name: "Thinkpad x220", price: 250 },
  { name: "Thinkpad x250", price: 979 }, { name: "Thinkpad x230", price: 300 },
  { name: "Thinkpad x230", price: 330 }, { name: "Thinkpad x230", price: 350 },
  { name: "Thinkpad x240", price: 700 }, { name: "Macbook Leopard", price: 300 },
  { name: "Macbook Air", price: 700 }, { name: "Macbook Pro", price: 600 },
  { name: "Macbook", price: 1449 }, { name: "Dell Latitude", price: 200 },
  { name: "Dell Latitude", price: 650 }, { name: "Dell Inspiron", price: 300 },
  { name: "Dell Inspiron", price: 450 },
]

query1 = {
  price_min: 240,
  price_max: 280,
  q: "thinkpad"
}

query2 = {
  price_min: 300,
  price_max: 450,
  q: "dell"
}

def name_contains?(product, criteria)
  product[:name].downcase.match?(criteria)
end

def price_between?(product, num1, num2)
  (num1..num2).cover?(product[:price])
end

def search(query)
  PRODUCTS.select do |product|
    name_contains?(product, query[:q])\
      && price_between?(product, query[:price_min], query[:price_max])
  end
end

# p search(query1)
# p search(query2)
