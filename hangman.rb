# Start program: new game or load game?
# load in the dictionary
# randomly select a word 5-12 characters
# display layout
#   - Show which correct letters 
#   - Show incorrect guesses
#   - Show how many tries left
# Add option to save game at start of turn
# player guesses a letter
# Add win/lose condition
def load_game
  Dir.mkdir('saves') unless Dir.exist?('saves')
  puts "load game!"
end

def new_game
  puts "new game!"
end

def main
  puts "Welcome to Hangman!"
  puts "Would you like to start a new game or load a previous game?"
  puts "reply: [new] [load] [quit]"
  input = gets.chomp.downcase
  if input == "new"
    new_game()
  elsif input == "load"
    load_game()
  elsif input == "quit"
    return
  else
    puts "Please try again"
    main()
  end
end

main()