# input array
# return hash where names are keys and values are array positions (indices)

puts 'PRACTICE PROBLEM 1'

flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]

flintstones_hash = {}

flintstones.each_with_index do |name, index|
  flintstones_hash[name] = index
end

p flintstones_hash

puts ''
puts 'PRACTICE PROBLEM 2'

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843,
         "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

sum_of_ages = 0

ages.each do |name, age|
  sum_of_ages += age
end

puts sum_of_ages

puts ''
puts 'PRACTICE PROBLEM 3'

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

ages.select! do |name, age|
  age < 100
end

p ages

puts ''
puts 'PRACTICE PROBLEM 4'

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, 
         "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

puts ages.values.sort[0]

puts ''
puts 'PRACTICE PROBLEM 5'

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

first = flintstones.find do |name, index|
  name.start_with?('Be')
end

puts flintstones.find_index(first)

puts ''
puts 'PRACTICE PROBLEM 6'

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

flintstones.map! do |name|
  name = name[0..2]
end

p flintstones

puts ''
puts 'PRACTICE PROBLEM 7'

statement = "The Flintstones Rock"

frequency = Hash.new(0)

statement.chars do |char|
  frequency[char] += 1
end

p frequency

puts ''
puts 'PRACTICE PROBLEM 8'

