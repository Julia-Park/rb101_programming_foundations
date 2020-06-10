require 'yaml'
MESSAGES = YAML.load_file('mortgage_calculator_messages.yml') # Use configuration file

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
  valid_num = begin
                float ? Float(ans) : Integer(ans)
              rescue 
                false
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
      puts prompt(MESSAGES["err_valid_num"])
    end
  end
end

puts prompt(MESSAGES["welcome"])

principle = input_loop(MESSAGES["principle_msg"])
apr = input_loop(MESSAGES["apr_msg"])
duration_years = input_loop(MESSAGES["duration_years_msg"])

puts prompt(MESSAGES["calculating"])

monthly_payments = mortgage(principle, apr, duration_years).round(2)

puts prompt(format(MESSAGES["result"], payments: monthly_payments, duration_months: duration_years.to_i*12))

puts prompt(MESSAGES["thank_you"])
