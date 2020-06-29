# Determine if an input string is an IP address representing dot-separted numbers
# - IP addresses have four "components" separated by a dot
# - Each component is a number between 0 and 255
#   - eg: 10.4.5.11
# is_an_ipnumber? returns true if numeric string is between 0 and 255 
# Feedback for Ben's code:  
# - Does not return a false condition
# - Not handling case where there are more or fewer than 4 components
#   - eg: 4.5.5 or 1.2.3.4.5 should be invalid

def dot_separated_ip_address?(input_string)
  dot_separated_words = input_string.split(".")

  # check if 4 components
  return false if dot_separated_words.size != 4

  while dot_separated_words.size > 0 do
    word = dot_separated_words.pop
    return false unless is_an_ip_number?(word) # return false if invalid component
  end
  
  return true
end
