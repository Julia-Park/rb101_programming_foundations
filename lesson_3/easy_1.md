# Question 1
1
2
2
3

# Question 2
The ! and ? is a valid character within the name of the object in Ruby.  It's convention.
1. what is != and where should you use it?
  != is a not-equal-to comparison operator.  It should be used to compare two objects and returns true or false.
2. put ! before something, like !user_name
  This returns the opposite of the truthiness of an object (true if object is not nil or false)
3. put ! after something, like words.uniq!
  This indicates that the method being called on the object is mutating the caller.
4. put ? before something
  Ternary operator for if...else
5. put ? after something
  Indicates whether method returns a true or false
6. put !! before something, like !!user_name
  This returns the truthiness of an object.

# Question 3 
advice = "Few things in life are as important as house training your pet dinosaur."
advice.gsub!("impoartant","urgent")

# Question 4
numbers.delete_at(1)
  delete number at index 1
  numbers = [1, 3, 4, 5]
numbers.delete(1)
  delete instances of value 1
  numbers = [2, 3, 4, 5]

# Question 5
(10..100).include?(42)

# Question 6
famous_ words = "seven years ago..."
1. famous_words = "Four score and " + famous_words
2. famous_words = famous_words.prepand("Four score and ")

# Question 7
flintsontes.flatten!

# Question 8
flintstones.assoc("Barney")
