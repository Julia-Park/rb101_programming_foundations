# write double_numbers! method such that the argument is mutated
# but otherwise, works like double_numbers

def double_numbers(numbers)
  doubled_numbers = []
  counter = 0

  loop do
    break if counter == numbers.size

    current_number = numbers[counter]
    doubled_numbers << current_number * 2

    counter += 1
  end

  doubled_numbers
end

def double_numbers!(numbers)
  counter = 0

  loop do
    break if counter == numbers.size

    numbers[counter] *= 2
    
    counter += 1
  end

  numbers
end

my_numbers = [1, 4, 3, 7, 2, 6]
puts "Before mutating method:"
puts "my_numbers:"
p my_numbers

puts "Checking methods..."

p double_numbers(my_numbers) == [2, 8, 6, 14, 4, 12]
puts "my_numbers:"
p my_numbers
p double_numbers!(my_numbers) == [2, 8, 6, 14, 4, 12]

puts "After mutating method:"
puts "my_numbers:"
p my_numbers
