# Improved join
# input array, optional separator and last separator strings
# - default last separator is 'or'
# - default separator is ', ' 
# return joined array using separator and last separators (see examples)
# - if array.size == 1, return only element
# - if array.size == 2, return element1 <last_separator> element2
# - if array.size > 2, return element1<separator>element2<separator>..elementn<separator> <last separator> lastelement

def joinor(array, separator = ', ', last_separator = 'or')
  case array.size
  when 0..2
    array.join(" #{last_separator} ")
  else
    front_elements_joined = (array[0..-2] + [last_separator]).join(separator)
    "#{front_elements_joined} #{array[-1]}"
  end
end

p joinor([1, 2])                   # => "1 or 2"
p joinor([1, 2, 3])                # => "1, 2, or 3"
p joinor([1, 2, 3], '; ')          # => "1; 2; or 3"
p joinor([1, 2, 3], ', ', 'and')   # => "1, 2, and 3"
