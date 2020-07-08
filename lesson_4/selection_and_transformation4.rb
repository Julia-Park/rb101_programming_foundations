# update double_numbers such that it can multiply by any number; new method multiply

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

def multiply(numbers, multiplier)
  multiplied_numbers = []
  index = 0

  loop do
    break if index == numbers.size

    multiplied_numbers << numbers[index] * multiplier

    index += 1
  end

  multiplied_numbers
end

my_numbers = [1, 4, 3, 7, 2, 6]
p multiply(my_numbers, 3) == [3, 12, 9, 21, 6, 18]
