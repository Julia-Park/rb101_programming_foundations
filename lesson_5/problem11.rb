# return new array identical in structure, but containing only multiples of 3

arr = [[2], [3, 5, 7], [9], [11, 13, 15]]

new_array =
  arr.map do |sub_array|
    sub_array.select do |integer|
      integer % 3 == 0
    end
  end

p new_array
