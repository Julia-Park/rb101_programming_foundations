# use map to return new array with identical structure, but integers incremented by 1

array = [{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}]

new_array =
  array.map do |hash|
    hash.map do |key, value|
      [key, value + 1]
    end.to_h
  end

p new_array
