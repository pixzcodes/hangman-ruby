# load in the dictionary
# randomly select a word 5-12 characters
# display layout
#   - Show which correct letters 
#   - Show incorrect guesses
#   - Show how many tries left
# Add option to save game at start of turn
# player guesses a letter
# Add win/lose condition

def play_game (word, lives = 6, guesses_arr = [] )
  puts "Game Start!"
  loop do

    puts "Incorrect guesses left: #{lives}"
    break
  end
end

def load_game
  puts "load game!" # place holder
end

def new_game
  puts "new game!" # place holder
  def find_word 
    dict = File.open('dictionary.txt', 'r')
    line_count = File.foreach('dictionary.txt').inject(0) {|c, line| c+1} # count lines in file
    rand_line = rand(1..line_count) # get a random line number based on how many lines in file
    word = ""
    dict.each do # find word associated with random line
      while rand_line > 0
        rand_line -= 1
        word = dict.gets.chomp
      end 
    end
    word
  end
  mystery_word = find_word()
  until mystery_word.length.between?(5,12)
    mystery_word = find_word()
  end
  p mystery_word
  play_game(mystery_word)
end

def main
  # make sure the saves folder is in the current directory
  Dir.mkdir('saves') unless Dir.exist?('saves')
  puts "Welcome to Hangman!"
  puts "Would you like to start a new game or load a previous game?"
  puts "reply: [new] [load] [quit]"
  input = gets.chomp.downcase # get input
  if input == "new"
    new_game()
  elsif input == "load"
    load_game()
  elsif input == "quit"
    return
  else
    puts "Please try again"
    main() # recursion yikes
  end
end

# main() # init main game

#remove this when done testing
new_game()