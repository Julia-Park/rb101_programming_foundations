# input array of numbers
# transform based on position in array
# double number if they have odd indices
# return array 

def double_odd_index(array)
  index = 0
  doubled_odd_index = []

  loop do
    break if index == array.size

    value = 
      index.odd? ? array[index]*2 : array[index]

    doubled_odd_index << value

    index += 1
  end

  doubled_odd_index
end

my_numbers = [1, 4, 3, 7, 2, 6]

p double_odd_index(my_numbers)
p double_odd_index(my_numbers) == [1, 8, 3, 14, 2, 12]
