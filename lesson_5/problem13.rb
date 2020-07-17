# return new array with same sub-arrays but ordered only by looking at odd numbers
# expected sorted array: [[1, 8, 3], [1, 6, 7], [1, 4, 9]]

arr = [[1, 6, 7], [1, 4, 9], [1, 8, 3]]

new_array =
  arr.sort_by do |sub_array|
    sub_array.select { |integer| integer.odd? }
  end

p new_array
