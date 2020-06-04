def prompt(message)
  # put => in front of all program generated messages for viewability
  Kernel.puts("=> #{message}")
end

def valid_number?(num)
  # use num.to_i() to test validity.
  # values that do not start with numbers will return 0.
  num == "0" || num.to_i() != 0
end

# deviating from the assignment video, DRY
def user_input_loop(message)
  loop do
    prompt(message)
    ans = Kernel.gets().chomp()

    if valid_number?(ans)
      return ans
    else
      prompt("Hmm... that doesn't look like a valid number")
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

prompt("Welcome to Calculator! Enter your name:")

name = ''
loop do
  name = Kernel.gets().chomp()

  if name.empty?()
    prompt("Make sure to use a valid name.")
  else
    break
  end
end

prompt("Hi #{name}!")

loop do # main loop
  number1 = user_input_loop("What's the first number?")

  number2 = user_input_loop("What's the second number?")

  # the following is a heredoc
  operator_prompt = <<-MSG
    What operation would you like to perform?
    1) add
    2) subtract
    3) multiply
    4) divide
  MSG

  prompt(operator_prompt)
  operator = ""

  loop do
    operator = Kernel.gets().chomp()

    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt("Must choose 1, 2, 3 or 4")
    end
  end

  prompt("#{operation_to_message(operator)} the two numbers...")

  # Use case instead of if to return the calculation directly to result
  # if can also return the result, but case is cleaner
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

  prompt("Do you want to perform another calculation? (Y to calculate again)")
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?("y")
end

prompt("Thank you for using the calculator!")
