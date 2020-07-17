# return hash where key is first item, value is 2nd item in each sub array
# expected return value: 
# {:a=>1, "b"=>"two", "sea"=>{:c=>3}, {:a=>1, :b=>2, :c=>3, :d=>4}=>"D"}

arr = [[:a, 1], ['b', 'two'], ['sea', {c: 3}], [{a: 1, b: 2, c: 3, d: 4}, 'D']]

new_array =
  arr.map do |sub_array|
    {sub_array[0] => sub_array[1] }
  end

p new_array
