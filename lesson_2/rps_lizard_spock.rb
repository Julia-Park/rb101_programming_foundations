GAME_CHOICES = ['rock', 'paper', 'scissors', 'lizard', 'spock']
GAME_CHOICES_ABV = ['r', 'p', 'sc', 'l', 'sp']
WIN_SCENARIOS = { rock: ['scissors', 'lizard'],
                  paper: ['rock', 'spock'],
                  scissors: ['paper', 'lizard'],
                  lizard: ['paper', 'spock'],
                  spock: ['scissors', 'rock'] }
WIN_MSG = 'You win! Computer loses!'
LOSE_MSG = 'You lose! Computer wins!'
TIE_MSG = "It's a tie!"
AFFIRMATIVE = ['y', 'yes']
NEGATIVE = ['n', 'no']

def prompt(message)
  puts(">> #{message}")
end

def win?(first, second)
  # test if first player won
  WIN_SCENARIOS[first.to_sym].include?(second)
end

def determine_result(player, computer)
  if win?(player, computer)
    WIN_MSG
  elsif win?(computer, player)
    LOSE_MSG
  else
    TIE_MSG
  end
end

def display_choices
  display = []

  GAME_CHOICES.each do |value|
    display << value + ' (' + GAME_CHOICES_ABV[GAME_CHOICES.index(value)] + ')'
  end

  display.join(', ')
end

def game_choice
  loop do
    prompt("Choose one: #{display_choices}")
    ans = gets.chomp.downcase

    # replace abbreviation with full word of choice
    if GAME_CHOICES_ABV.include?(ans)
      ans = GAME_CHOICES[GAME_CHOICES_ABV.index(ans)]
    end

    return ans if GAME_CHOICES.include?(ans)
    prompt("That's not a valid choice!")
  end
end

def continue_ans(criteria_msg)
  loop do
    prompt(criteria_msg)
    ans = gets.chomp.downcase

    return ans if AFFIRMATIVE.include?(ans) || NEGATIVE.include?(ans)
  end
end

prompt("Let's play #{GAME_CHOICES.join(', ')}!")
prompt("The first to win 5 games is the match's grand champion!")

loop do # match loop begin
  puts "----- NEW MATCH BEGINS! -----\n"
  player_wins = 0
  computer_wins = 0
  total_games = 1

  loop do # game loop begin
    puts "- GAME #{total_games} -"

    # Player choice
    choice = game_choice

    # Computer choice
    computer_choice = GAME_CHOICES.sample

    prompt("You chose #{choice}.  The computer chose #{computer_choice}.")

    # Figure out and display result of match up
    result = determine_result(choice, computer_choice)
    prompt(result)

    # Tally scores and games
    if result == WIN_MSG
      player_wins += 1
    elsif result == LOSE_MSG
      computer_wins += 1
    end

    total_games += 1

    prompt("The current score is player: #{player_wins} and " \
          "computer: #{computer_wins}!")

    # Check if player/computer has 5 wins to end match
    if player_wins == 5
      prompt('The match is over. You are the GRAND CHAMPION!')
      break
    elsif computer_wins == 5
      prompt('The match is over. The computer is the GRAND CHAMPION!')
      break
    end

    prompt('Do you want to continue playing the match?')
    answer = continue_ans("Enter yes or y to continue, no or n to stop.")

    break if NEGATIVE.include?(answer)

    puts "\n\n"
  end # game loop end

  prompt('Do you want to play another match?')
  answer = continue_ans("Enter yes or y to play again, no or n to exit.")

  break if NEGATIVE.include?(answer)

  puts "\n\n\n\n\n"
end # match loop end

prompt('Thank you for playing. Goodbye!')
