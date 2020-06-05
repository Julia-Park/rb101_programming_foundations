require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml') # Use configuration file

def prompt(message)
  Kernel.puts("=> #{message}")
end

def valid_number?(num)
  # Find a better way to validate number
  valid = Float(num) rescue false
  valid ? true : false
end

# deviating from the assignment video, DRY
def user_input_loop(message)
  loop do
    prompt(message)
    ans = Kernel.gets().chomp()

    if valid_number?(ans)
      return ans
    else
      prompt(MESSAGES['valid_number'])
    end
  end
end

def operation_to_message(op)
  case op
  when '1'
    'Adding'
  when '2'
    'Subtracting'
  when '3'
    'Multiplying'
  when '4'
    'Dividing'
  end
end

prompt(MESSAGES['welcome'])

name = ''
loop do
  name = Kernel.gets().chomp()

  if name.empty?()
    prompt(MESSAGES['valid_name'])
  else
    break
  end
end

prompt("Hi #{name}!")

loop do # main loop
  number1 = user_input_loop(MESSAGES['first_number'])

  number2 = user_input_loop(MESSAGES['second_number'])

  # the following is a heredoc
  prompt(MESSAGES['operator'])
  operator = ""

  loop do
    operator = Kernel.gets().chomp()

    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt(MESSAGES['valid_operator'])
    end
  end

  prompt("#{operation_to_message(operator)} the two numbers...")

  result =  case operator
            when '1'
              number1.to_i() + number2.to_i()
            when '2'
              number1.to_i() - number2.to_i()
            when '3'
              number1.to_i() * number2.to_i()
            when '4'
              number1.to_f() / number2.to_f()
            end

  prompt("The result is #{result}")

  prompt(MESSAGES['calculate_again'])
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?("y")
end

prompt(MESSAGES['thank_you'])
