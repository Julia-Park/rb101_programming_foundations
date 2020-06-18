# Question 1
ages["Spot"].nil?
ages.fetch_values("Spot") rescue false
ages.fetch("Spot", false)
ages.filter { |k, v| k = "Spot" }
ages.key?("Spot")
ages.include?("Spot")
ages.member?("Spot")

# Question 2
munsters_description = "The Munsters are creepy in a good way."
1. "tHE mUNSTERS ARE CREEPY IN A GOOD WAY."
  munsters_description.swapcase!

2. "The munsters are creepy in a good way."
  munsters_description.capitalize!

3. "the munsters are creepy in a good way."
  munsters_description.downcase!

4. "THE MUNSTERS ARE CREEPY IN A GOOD WAY."
  munsters_description.upcase!

# Question 3
ages.merge!(additional_ages)

# Question 4
advice.include?("Dino")

# Question 5
flintstones = ["Fred", "Barney", "Wilma", "Betty", "BamBam", "Pebbles"]
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

# Question 6
flintstones << "Dino"

# Question 7
flintstones.concat(%w{Dino Hoppy})

# Question 8
advice = "Few things in life are as important as house training your pet dinosaur."
advice.slice!(0.advice.index('house'))
Using String#slice returns the section of the string specified by the argument passed into the method, but leaves the original caller intact.

# Question 9
statement.count('t')

# Question 10
title = "Flintstone Family Members"
char_prepend = 20 - ( title.length / 2 )
char_prepend.times do { title = ' ' + title }

title.center(40)
