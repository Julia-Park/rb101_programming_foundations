require 'yaml'

MESSAGES = YAML.load_file('rps_lizard_spock_messages.yml')
GAME_CHOICES = ['rock', 'paper', 'scissors', 'lizard', 'spock']
GAME_CHOICES_ABV = ['r', 'p', 'sc', 'l', 'sp']
WIN_SCENARIOS = { rock: ['scissors', 'lizard'],
                  paper: ['rock', 'spock'],
                  scissors: ['paper', 'lizard'],
                  lizard: ['paper', 'spock'],
                  spock: ['scissors', 'rock'] }
AFFIRMATIVE = ['y', 'yes']
NEGATIVE = ['n', 'no']
MATCH_WIN_NUMBER = 5

def prompt(message)
  puts(">> #{message}")
end

def win?(first, second)
  # test if first player won
  WIN_SCENARIOS[first.to_sym].include?(second)
end

def display_result(player, computer)
  if win?(player, computer)
    MESSAGES['win']
  elsif win?(computer, player)
    MESSAGES['lose']
  else
    MESSAGES['tie']
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
    prompt(format(MESSAGES['game_instruction'], choices: display_choices))
    ans = gets.chomp.downcase

    # replace abbreviation with full word of choice
    if GAME_CHOICES_ABV.include?(ans)
      ans = GAME_CHOICES[GAME_CHOICES_ABV.index(ans)]
    end

    return ans if GAME_CHOICES.include?(ans)
    prompt(MESSAGES['invalid_choice'])
  end
end

def retrieve_continue_answer(initial_msg, criteria_msg)
  puts "\n"
  prompt(initial_msg)

  loop do
    prompt(criteria_msg)
    ans = gets.chomp.downcase

    return ans if AFFIRMATIVE.include?(ans) || NEGATIVE.include?(ans)
  end
end

def display_welcome
  puts "\n"
  prompt(format(MESSAGES['rpsls_intro'], game_name: GAME_CHOICES.join(', ')))
  prompt(format(MESSAGES['rpsls_description'],
                match_condition: MATCH_WIN_NUMBER))
  puts "\n"
end

def display_game_start(scores)
  puts format(MESSAGES['game_num'], number: scores[:total_games])
  prompt(display_score(scores))
end

def update_scores(game_result, scores)
  if game_result == MESSAGES['win']
    scores[:player] += 1
  elsif game_result == MESSAGES['lose']
    scores[:computer] += 1
  end

  scores[:total_games] += 1
end

def display_score(scores)
  format(MESSAGES['current_score'],
         player_wins: scores[:player],
         computer_wins: scores[:computer])
end

def winner?(score)
  score == MATCH_WIN_NUMBER
end

def display_match_winner(scores)
  if winner?(scores[:player])
    MESSAGES['player_is_champion']
  elsif winner?(scores[:computer])
    MESSAGES['computer_is_champion']
  end
end

# RPSLS start

display_welcome

loop do # Match loop begin
  puts MESSAGES['new_match']

  match_scores = { player: 0,
                   computer: 0,
                   total_games: 1 }

  loop do # Game loop begin
    display_game_start(match_scores)

    # Player choice
    choice = game_choice

    # Computer choice
    computer_choice = GAME_CHOICES.sample

    # Display choices
    prompt(format(MESSAGES['selected_choices'],
                  player: choice,
                  computer: computer_choice))

    result = display_result(choice, computer_choice)
    prompt(result)

    update_scores(result, match_scores)

    prompt(display_score(match_scores))

    # Check if player/computer has enough wins to end match
    result = display_match_winner(match_scores)

    unless result.nil?
      prompt(result)
      break
    end

    # Continue match?
    answer = retrieve_continue_answer(MESSAGES['continue_match'],
                                      MESSAGES['continue_match_choices'])
    break if NEGATIVE.include?(answer)

    system("clear")
  end # Game loop end

  # New match?
  answer = retrieve_continue_answer(MESSAGES['another_match'],
                                    MESSAGES['another_match_choices'])
  break if NEGATIVE.include?(answer)

  system("clear")
end # Match loop end

puts("\n")
prompt(MESSAGES['thank_you'])
