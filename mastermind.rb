puts "Try to guess 4 colors in right order. There are 6 colors represented by numbers (yellow = 1, orange = 2, red = 3, green = 4, blue = 5, black = 6). Colors can be repeated. If you guess right color at right position you will see: '\u2022'. If you guess right color but at wrong position, you will see: 'o'. You can guess 12 times.

Example:
Generated colors: 1216.
Your guess: 2311
Hint: \u2022 o o. 
(2 is at wrong place - o, first 1 is at correct place - \u2022, but second 1 is at wrong place - o)

"

def generate_colors
	arr_of_colors=[]
	for i in 0..3 do
		arr_of_colors.push(rand(6)+1)
	end

	arr_of_colors
end

class Mastermind
	attr_accessor :colors
	def initialize(mode=0, colors=generate_colors)
    @colors=colors
    @mode = mode
  end
  
  def mode_of_game
    if @mode == 0
      gameplay
    elsif @mode == 1
      puts "Write colors (numbers) for computer to guess."
    else
      puts "Write 0 or 1."
      mode_of_game
    end
  end

  def ask_for_guess
    puts "Guess colors: "
    guess = gets.chomp.chars
    guess.map! {|el| el.to_i}
    guess
  end

  def evaluate_guess(guess)
    right_positions_count=0
    right_numbers_count =0
    matched_indexes =[]
    has_won = false
    i=0
    for i in 0..3      
      for j in 0..3
        if (guess[i]==@colors[j] && i ==j)
          right_positions_count+=1
          matched_indexes.push(j)
          break
        elsif guess[i]==@colors[j] && !matched_indexes.include?(j) &&  guess[i]!= guess[j]
          right_numbers_count+=1
          matched_indexes.push(j)
          break
        end
      end
    end
    if right_positions_count == 4
        puts "You won!"
        has_won = true
    end
    return [right_positions_count, right_numbers_count, has_won]

  end

  def show_hint(evaluated_guesses)

    for i in 1..evaluated_guesses[0]
      if evaluated_guesses[2]
        break
      end
      print "\u2022" 
    end
    for i in 1..evaluated_guesses[1]
      print "o" 
    end
    puts
    evaluated_guesses
  end

  def gameplay
    for i in 1..13
      evaluated_guesses=self.evaluate_guess(self.ask_for_guess)
      self.show_hint(evaluated_guesses)
      if evaluated_guesses[2]==true
        break
      end
      if i==13
        puts "You Lost"
      end   
    end
  puts "Generated colors were #{@colors.join}."
  end
end

game1 = Mastermind.new(1)
game1.gameplay