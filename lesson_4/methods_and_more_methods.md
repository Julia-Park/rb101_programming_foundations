# Practice Problem 1
The return value is [1, 2, 3].
Select evaluates the return value of the block based on its truthiness and selects the elements from the collection it's called on to return a new collection.  Since 'hi' is the last statement in the block regardless of the value of the element (which is truthy), all elements from the collection will be returned in a new collection.

# Practice Problem 2
`count` looks at the truthiness of the return value for each element in the collection. It returns the number of elements within the collection which return a truthy value when passed through the block.
We can find out through the documentation.

# Practice Problem 3
The return value is [1, 2, 3].
Reject returns an array that contains all elements which returned a falsey value (false or nil).  When elements are passed through the block, they will all return nil regardless of the element due to `puts`.  

# Practice Problem 4
The return value is {'a' => 'ant', 'b' => 'bear', 'c' => 'cat'}
`each_with_object` takes a collection object in as a method argument and the value of the element and the collection object as block arguments.
Breaking down Line 2:
value[0] refers to the first letter of the value of the element passed into the block.
hash[value[0]] = value then assigns value as the value at key value[0].  This means for every element of the array, the first letter of the element becomes the key and the element itself becomes the value in the returned collection of the method.

# Practice Problem 5
`shift` removes a key-value pair from the hash it's called on and returns it as a two-item array [key, value].
This can be found in the documentation under `Hash#shift`

# Practice Problem 6
It returns 11.
`Array#pop` removes and returns the last element of the array.
`size` returns the length of the object, in this case, a string.
'caterpillar' is the last element of the array.  It is 11 characters long.

# Practice Problem 7
The block's return value is true or false, depending on whether num is odd.
It is determined by looking at the last line of code before `end`, which is `num.odd?`.
`any?` returns true or false depending on if any elements passed through the block return a truthy value.
In this case, this method call will return true since `num.odd?` from within the block will return true in at least one element in the array called on `any?`.
Note, after the first element (1), `any?` will stop running since the block returns true and satisfies the condition for `any?` to also return true.

# Practice Problem 8
`take` returns the first n elements of an array, n being a parameter for the method.
It is not destructive, but the documentation for this is not completely clear.  It is best to test in irb just in case.

# Practice Problem 9
It will return [nil, 'bear'].
When none of the conditions in an if statement evaluates as `true`, the if statement will return `nil`.

# Practice Problem 10
[1, nil, nil]
`puts` returns nil.
