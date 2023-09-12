INITIAL = " "
USER_MARKER = "X"
COMP_MARKER = "O"
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9],
                 [1, 4, 7], [2, 5, 8], [3, 6, 9],
                 [1, 5, 9], [3, 5, 7]]

def prompt(msg)
  puts "=> #{msg}"
end

def intitialze_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL }
  new_board
end

def initialize_demo_board
  demo_board = {}
  (1..9).each { |num| demo_board[num] = num }
  demo_board
end

def game_intro
  demo_board = initialize_demo_board
  display_board(demo_board)
  prompt("Welcome to the game of Tic Tac Toe!")
  puts ""
  prompt("You're #{USER_MARKER}. Computer is #{COMP_MARKER}.")
  prompt("We are playing best of 5 so first to 3 wins, tie's don't count")
  prompt("Square numbers are shown in the above board")
  prompt("You can mark a square by entering the corresponding square number")
  puts ""
end

# rubocop:disable Metrics/AbcSize
def display_board(brd_hsh)
  system 'clear'
  puts ""
  puts "   |   |"
  puts " #{brd_hsh[1]} | #{brd_hsh[2]} | #{brd_hsh[3]}"
  puts "   |   |"
  puts "---+---+----"
  puts "   |   |"
  puts " #{brd_hsh[4]} | #{brd_hsh[5]} | #{brd_hsh[6]}"
  puts "   |   |"
  puts "---+---+----"
  puts "   |   |"
  puts " #{brd_hsh[7]} | #{brd_hsh[8]} | #{brd_hsh[9]}"
  puts "   |   |"
  puts ""
end
# rubocop:enable Metrics/AbcSize

def joinor(valid_moves, separator = ", ", connector = "or")
  if valid_moves.size > 1
    "#{valid_moves[0..-2].join(separator)} #{connector} #{valid_moves[-1]}"
  else
    valid_moves[0].to_s
  end
end

def invalid_input?(user_move)
  user_move.to_i == 0 || user_move.to_i > 9
end

def prompt_invalid_input
  puts "******************"
  prompt("Invalid input! Input again.")
  puts "******************"
end

def prompt_choice_taken?
  prompt("This choice is taken")
  prompt("Go again...")
end

def choice_taken?(brd, user_move)
  brd[user_move] == USER_MARKER || brd[user_move] == COMP_MARKER
end

def go_first
  puts "Would you like to go first? y/n"
  answer = gets.chomp

  if answer.start_with?('y')
    "Player"
  else
    "Computer"
  end
end

def display_result_per_round(round_winner)
  case round_winner
  when "Player"
    prompt("You won!!!!")
  when "Computer"
    prompt("Computer won...!")
  else
    prompt("It's a tie!")
  end
end

def someone_won?(brd)
  WINNING_LINES.each do |win_arr|
    if win_arr.all? { |value| brd[value] == USER_MARKER } ||
       win_arr.all? { |value| brd[value] == COMP_MARKER }
      return true
    end
  end
  false
end

def determine_who_won(brd)
  WINNING_LINES.each do |win_arr|
    return "Player" if win_arr.all? { |value| brd[value] == USER_MARKER }
    return "Computer" if win_arr.all? { |value| brd[value] == COMP_MARKER }
  end
end

def display_best_of_five_winner(user_score, comp_score)
  if user_score > comp_score
    prompt("You are the winner of best of 5, Congratulations!!")
  elsif comp_score > user_score
    prompt("Sorry computer won this best of 5 :(")
  end
end

def display_game_number(times_played)
  prompt("This is game number: #{times_played}")
end

# In the case where there is no threat and no defense then go for offense
# rather than a random move
def avoid_useless_move(brd, valid_moves)
  WINNING_LINES.each do |win_arr|
    if brd.values_at(*win_arr).count(" ") == 1
      avoid_moves_arr = brd.values_at(*win_arr).select { |v| v == " " }
      useful_move_arr = valid_moves - avoid_moves_arr

      return useful_move_arr[0]
    end
  end
  false
end

def find_immediate_threat?(brd)
  WINNING_LINES.each do |win_arr|
    if brd.values_at(*win_arr).count(USER_MARKER) == 2 &&
       brd.values_at(*win_arr).any?(" ")
      user_marked_arr = brd.keys.select do |k|
        brd[k] == USER_MARKER && brd[k] != COMP_MARKER
      end
      threat_arr = (win_arr - user_marked_arr)
      return threat_arr[0]
    end
  end
  false
end

def find_offensive_move?(brd)
  WINNING_LINES.each do |win_arr|
    if brd.values_at(*win_arr).count(COMP_MARKER) == 2 &&
       brd.values_at(*win_arr).any?(" ")
      currently_used_spaces = brd.keys.select do |k|
        brd[k] == COMP_MARKER && brd[k] != USER_MARKER
      end
      offensive_move_arr = (win_arr - currently_used_spaces)

      return offensive_move_arr[0]
    end
  end
  false
end

# rubocop:disable Metrics/MethodLength
def get_computer_move!(brd, valid_moves)
  prompt("Computer's turn now...")
  sleep(1.5)

  threat = find_immediate_threat?(brd)
  offense = find_offensive_move?(brd)
  useful_move = avoid_useless_move(brd, valid_moves)

  if offense != false               # go for offense if available
    computer_move = offense
  elsif threat != false             # if there is a threat then defend
    computer_move = threat
  elsif valid_moves.include?(5)     # if middle cell is available then take it
    computer_move = 5
  elsif useful_move != false        # no threat yet, then go for offense
    computer_move = useful_move
  else                              # pick random
    computer_move = valid_moves.sample
  end

  brd[computer_move] = COMP_MARKER
  display_board(brd)
  computer_move
end
# rubocop:enable Metrics/MethodLength

def update_valid_moves!(move, valid_moves)
  valid_moves.delete_if { |index| index == move }
end

def display_score(user_score, comp_score)
  prompt("You have won #{user_score} out of 3 games in a best of 5")
  prompt("Computer has won #{comp_score} out of 3 games in a best of 5")
  puts "****************************************"
  puts ""
end

def keep_score(round_winner, user_score, comp_score)
  case round_winner
  when "Player"
    user_score += 1
  when "Computer"
    comp_score += 1
  end
  [user_score, comp_score]
end

def get_user_move!(brd, valid_moves, user_move = '')
  loop do
    prompt("Your turn, enter a square from these #{joinor(valid_moves)}")
    user_move = gets.to_i

    if invalid_input?(user_move)
      prompt_invalid_input
      next
    end

    if choice_taken?(brd, user_move)
      prompt_choice_taken?
      next
    end

    brd[user_move] = USER_MARKER
    break
  end
  user_move
end

def play_a_round(brd, who_goes)
  valid_moves = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  display_board(brd)

  if who_goes == "Computer"
    computer_move = get_computer_move!(brd, valid_moves)
    update_valid_moves!(computer_move, valid_moves)
  end

  loop do
    user_move = get_user_move!(brd, valid_moves)
    update_valid_moves!(user_move, valid_moves)
    display_board(brd)
    break if someone_won?(brd) || valid_moves.empty?

    computer_move = get_computer_move!(brd, valid_moves)
    update_valid_moves!(computer_move, valid_moves)

    break if someone_won?(brd) || valid_moves.empty?
  end
end

def determine_who_goes(who_goes)
  who_goes == "Computer" ? "Player" : "Computer"
end

def display_who_goes(who_goes)
  if who_goes == "Computer"
    prompt("Computer goes first this round")
  else
    prompt('Player goes first this round')
  end
end

# rubocop:disable Metrics/MethodLength
def main_game(who_goes, user_score = 0, comp_score = 0)
  times_played = 1
  round_winner = ""
  loop do
    display_who_goes(who_goes)
    display_game_number(times_played)
    puts("Hit Enter ↵ to start")
    gets.chomp
    board = intitialze_board
    play_a_round(board, who_goes)
    round_winner = determine_who_won(board)
    display_board(board)
    display_result_per_round(round_winner)
    user_score, comp_score = keep_score(round_winner, user_score, comp_score)
    display_score(user_score, comp_score)
    times_played += 1
    who_goes = determine_who_goes(who_goes)
    break if user_score >= 3 || comp_score >= 3
  end
  display_best_of_five_winner(user_score, comp_score)
end
# rubocop:enable Metrics/MethodLength
system 'clear'

loop do
  game_intro
  who_goes = go_first
  main_game(who_goes)
  puts "****************************************"
  prompt("Do you want to play again? y/n")
  choice = gets.chomp
  break if choice.start_with?("n")
  system 'clear'
end

prompt("Thank you for playing Tic Tac Toe!")
