require 'pry'

INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
PLAYER_NAME = 'Player'
COMPUTER_NAME = 'Computer'

def prompt(msg)
  puts ">> #{msg}"
end

def joinor(array, separator = ', ', last_separator = 'or')
  case array.size
  when 0..2
    array.join(" #{last_separator} ")
  else
    front_elements_joined = (array[0..-2] + [last_separator]).join(separator)
    "#{front_elements_joined} #{array[-1]}"
  end
end

def display_board(brd)
  system 'clear'
  puts "You are #{PLAYER_MARKER}.  #{COMPUTER_NAME} is #{COMPUTER_MARKER}."
  puts ''
  puts '     |     |     '
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}  "
  puts '     |     |     '
  puts '-----+-----+-----'
  puts '     |     |     '
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}  "
  puts '     |     |     '
  puts '-----+-----+-----'
  puts '     |     |     '
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}  "
  puts '     |     |     '
  puts ''
end

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a square (#{joinor(empty_squares(brd))}):"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry, that's not a valid choice"
  end
  brd[square] = PLAYER_MARKER
end

def computer_places_piece!(brd)
  square = empty_squares(brd).sample
  brd[square] = COMPUTER_MARKER
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def detect_winner(brd)
  winning_lines =
    [[1, 2, 3], [4, 5, 6], [7, 8, 9],
     [1, 4, 7], [2, 5, 8], [3, 6, 9],
     [1, 5, 9], [3, 5, 7]]

  # deviating from video
  winning_lines.each do |line|
    markers_in_line = line.map { |square| brd[square] }.uniq
    case markers_in_line
    when [PLAYER_MARKER]
      return PLAYER_NAME
    when [COMPUTER_MARKER]
      return COMPUTER_NAME
    end
  end

  nil
end

def someone_won?(brd)
  # use !! to turn return value of method to boolean
  !!detect_winner(brd)
end

def current_score(scrs)
  "The current score is: "\
  "#{PLAYER_NAME}: #{scrs[PLAYER_NAME]} "\
  "#{COMPUTER_NAME}: #{scrs[COMPUTER_NAME]}"
end

def keep_score!(scrs, winning_player)
  # update scores
  case winning_player
  when PLAYER_NAME    then scrs[PLAYER_NAME] += 1
  when COMPUTER_NAME  then scrs[COMPUTER_NAME] += 1
  end
end

def detect_game_winner(scrs)
  scrs.key(5)
end

def initialize_scores
  {PLAYER_NAME => 0, COMPUTER_NAME => 0}
end

# Game logic
scores = initialize_scores

loop do
  board = initialize_board

  # Game Loop
  loop do
    display_board(board)
    prompt current_score(scores)

    player_places_piece!(board)
    break if someone_won?(board) || board_full?(board)

    computer_places_piece!(board)
    break if someone_won?(board) || board_full?(board)
  end

  display_board(board)

  if someone_won?(board)
    winner = detect_winner(board)
    keep_score!(scores, winner)
    prompt "#{winner} won!"
    prompt current_score(scores)
  else
    prompt "It's a tie!"
    prompt current_score(scores)
  end

  if detect_game_winner(scores)
    prompt "#{detect_game_winner(scores)} is the first to 5 wins. They win the game!"
    scores = initialize_scores
  end

  prompt 'Play again? (y or n)'
  answer = gets.chomp.downcase
  break unless answer.start_with?('y')
end

prompt 'Thanks for playing Tic Tac Toe!  Good bye!'
