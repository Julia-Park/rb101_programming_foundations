VALID_CHOICES = ['rock', 'paper', 'scissors', 'lizard', 'spock']
VALID_CHOICES_ABV = VALID_CHOICES.map do |ans|
                      case ans
                      when 'scissors', 'spock'
                        ans[0..1]
                      else
                        ans[0]
                      end
                    end
WIN_SCENARIOS = { rock: ['scissors', 'lizard'],
                  paper: ['rock', 'spock'],
                  scissors: ['paper', 'lizard'],
                  lizard: ['paper', 'spock'],
                  spock: ['scissors', 'rock']
                }

WIN_MSG = 'You win! Computer loses!'
LOSE_MSG = 'You lose! Computer wins!'
TIE_MSG = "It's a tie!"

def prompt(message)
  puts(">> #{message}")
end

def win?(first, second)
  # test if first player won
  WIN_SCENARIOS[first.to_sym].include?(second)
end

def get_result(player, computer)
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

  VALID_CHOICES.each do |value|
    display << value + ' (' + VALID_CHOICES_ABV[VALID_CHOICES.index(value)] +')'
  end

  return display.join(', ')
end

def get_choice
  loop do
    prompt("Choose one: #{display_choices}")
    ans = gets.chomp.downcase

    ans = VALID_CHOICES[VALID_CHOICES_ABV.index(ans)] if VALID_CHOICES_ABV.include?(ans)
    
    return ans if VALID_CHOICES.include?(ans)
    prompt("That's not a valid choice!")
  end
end

prompt("Let's play #{VALID_CHOICES.join(', ')}!")
prompt("The first to win 5 games is the match's grand champion!")

loop do # match loop begin
  puts "----- NEW MATCH BEGINS! -----\n"
  player_wins = 0
  computer_wins = 0
  total_games = 1
  
  loop do # game loop begin
    puts "- GAME #{total_games} -"

    choice = get_choice

    computer_choice = VALID_CHOICES.sample

    prompt("You chose #{choice}.  The computer chose #{computer_choice}.")

    result = get_result(choice, computer_choice)
    prompt(result)

    if result == WIN_MSG
      player_wins += 1
    elsif result == LOSE_MSG
      computer_wins += 1
    end
    total_games += 1

    prompt("The current score is player: #{player_wins} and computer: #{computer_wins}!")
  
    if player_wins == 5
      prompt('The game is over. You are the GRAND CHAMPION!')
      break
    elsif computer_wins == 5
      prompt('The game is over. The computer is the GRAND CHAMPION!')
      break
    end

    prompt("Do you want to keep playing? Enter 'yes' or 'y' to continue the match.")
    answer = gets.chomp.downcase
    break unless ['y', 'yes'].include?(answer)

    puts "\n"
  end # game loop end

  prompt("Do you want to play another match? Enter 'yes' or 'y' to begin new match.")
  answer = gets.chomp.downcase
  break unless ['y', 'yes'].include?(answer)
  
  puts "\n\n\n\n\n"
end # match loop end

prompt('Thank you for playing. Goodbye!')
