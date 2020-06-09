def mortgage(p, a, y)
  # Calculate monthly payments
  # p = principle, a = APR, y = loan duration in years

  # convert APR deciml and to monthly
  j = a.to_f / 100 / 12
  # convert loan duration in years to months
  n = y.to_i * 12
  # calculate monthly payment
  p.to_f * (j / (1 - (1 + j)**(-n)))
end

def prompt(sentence)
  # adds >> at the beginning for program messages
  ">> " + sentence
end

def validate_ans(ans, float=true)
  # Validate user provided answer; should be integer/float and > 0
  valid_num = if float
                Float(ans) rescue false
              else
                Integer(ans) rescue false
              end
  valid_num && ans.to_f > 0 ? true : false
end

def input_loop(question, float=true)
  # Looping promopt for valid answer.  Returns valid answer.
  loop do
    puts prompt(question)
    answer = gets.chomp
    if validate_ans(answer, float)
      return answer
    else
      puts prompt("Please enter a valid number greater than zero.")
    end
  end
end

puts prompt("Welcome to the Mortgage Calculator!")

principle = input_loop("What is the loan amount? (Principle)")
apr = input_loop("What is the annual percentage rate? (APR)")
duration_years = input_loop("What is the loan duration in years?")

puts prompt("Calculating...")

monthly_payments = mortgage(principle, apr, duration_years).round(2)

puts prompt("Your monthly payments are $#{monthly_payments} for #{duration_years.to_i * 12} months.")

puts prompt("Thank you for using the calculator!")
