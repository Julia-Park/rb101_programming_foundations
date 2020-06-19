def factors(number)
  divisor = number
  factors = []

  while divisor > 0 do
    factors << number / divisor if number % divisor == 0 # push quotient only if no remainder
    divisor -= 1
  end

  factors # return array of factors
end

puts factors(0)
puts factors(10)
