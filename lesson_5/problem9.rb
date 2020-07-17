arr = [['b', 'c', 'a'], [2, 1, 3], ['blue', 'black', 'green']]

# return new array of same structure but with sub arrays being ordered in descending order

new_array =
  arr.map do |sub_array|
    sub_array.sort { |a, b| b <=> a }
  end

p new_array
