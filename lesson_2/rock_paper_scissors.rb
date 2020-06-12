VALID_CHOICES = ['rock', 'paper', 'scissors']

def prompt(message)
  puts("=> #{message}")
end

def win?(first, second)
  # test if first player won
  case [first, second]
  when ['rock', 'scissors'], ['scissors', 'paper'], ['paper', 'rock'] then true
  end
end

def display_result(player, computer)
  if win?(player, computer)
    'You win!'
  elsif win?(computer, player)
    'You lose!'
  else
    "It's a tie!"
  end
end

prompt("Let's play #{VALID_CHOICES.join(', ')}!")

loop do
  choice = ''
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}")
    choice = gets.chomp.downcase
    break if VALID_CHOICES.include?(choice)
    prompt("That's not a valid choice!")
  end

  computer_choice = VALID_CHOICES.sample

  prompt("You chose #{choice}.  The computer chose #{computer_choice}.")

  prompt(display_result(choice, computer_choice))

  prompt('Do you want to play again?')
  answer = gets.chomp.downcase
  break unless answer.start_with?('y')
end

prompt('Thank you for playing. Good bye!')
