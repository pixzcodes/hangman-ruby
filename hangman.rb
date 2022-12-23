# HANGMAN



def save (word, word_display, lives, guesses_arr)
  puts "...saving..." 
  filename = "saves/#{word_display.delete(' ')}.txt"

  File.open(filename, 'w') do |file|
    file.puts word
    file.puts word_display
    file.puts lives
    file.puts guesses_arr.join(' ')
  end
  puts "Game saved as #{filename}"
  main()
end

def load_game
  puts "load game!" # place holder
  games = []
  Dir['saves/*'].each_with_index do |file, index|
    puts "Save ##{index + 1}: #{file}"
    games << file
  end
  puts "Please enter the number of the game file"
  puts "you would like to load..."
  loop do
    input = gets.chomp
    if games.values_at(input.to_i).any? && input.match(/\d+/)
      puts "File selected: #{games[input.to_i - 1]}"
      game_file = File.new(games[input.to_i - 1])
      word = game_file.gets.chomp
      word_display = game_file.gets.chomp
      lives = game_file.gets.chomp.to_i
      guesses_arr = game_file.gets
      game_file.close
      if guesses_arr == nil
        guesses_arr = []
      else
        guesses_arr = guesses_arr.chomp.split
      end
      play_game(word, true, word_display, lives, guesses_arr)
      break
    else
      puts "Please try again"
    end
  end
end

def play_game ( word, loaded = false, word_display = "", lives = 6, guesses_arr = [] )
  
  puts "Game Start!"
  if loaded == false # create underscore display for word if new game
    word_display = word.gsub(/[a-z]/, '_ ')
  end

  loop do
    puts "---------------------------------------"
    puts "The word is { #{word_display} }"
    puts "Incorrect guesses left: #{lives}"
    puts "Wrong letters you've guessed: "
    puts guesses_arr.join(", ")
    puts "You can enter [save] or"
    puts "type a letter and enter..."
    input = gets.chomp.downcase()
    if input == "save"
      save(word, word_display, lives, guesses_arr)
      break
    elsif input.length == 1 && input.match(/[a-z]/)
      if guesses_arr.any?(input) || word_display.split.any?(input)
        puts "...well this is awkward..."
        puts "You guessed that letter already..."
      elsif word.split('').any?(input)
        puts "Congrats you found a match!"
        display_arr = word_display.split # turn display into an array
        word_arr = word.split('') # turn mystery word into an array
        word_arr.each_with_index do |letter, index| # cycle through to find matches and change the display
          if letter == input
            display_arr[index] = input
          end
        end
        word_display = display_arr.join(' ') # put display back together
      else
        puts "Nope! That's not it"
        puts "-1 guesses left..."
        lives -= 1
        guesses_arr << input
      end
    else 
      puts "Please try again..."
    end

    # WIN / LOSE CONDITIONS
    if lives <= 0 
      puts "Oh no you ran out of guesses!"
      puts "Looks like you lose!"
      puts "The word was #{word}"
      puts "Number of incorrect guesses: #{guesses_arr.length}"
      puts "Better luck next time!"
      break
    end
    if word_display.split.any?('_') == false
      puts "You guessed the word!"
      puts "Congradulations you win!"
      puts "Number of incorrect guesses: #{guesses_arr.length}"
      puts "Thanks for playing!"
      break
    end
  end
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
  p mystery_word # remove before production
  play_game(mystery_word)
end

def main
  # make sure the saves folder is in the current directory
  Dir.mkdir('saves') unless Dir.exist?('saves')
  puts "Welcome to Hangman!"
  puts "Would you like to start a new game or load a previous game?"
  puts "reply: [new] [load] [quit]"
  loop do
    input = gets.chomp.downcase # get input
    if input == "new"
      new_game()
      break
    elsif input == "load"
      load_game()
      break
    elsif input == "quit"
      break
    else
      puts "Please try again"
    end
  end
end

main() # init main game