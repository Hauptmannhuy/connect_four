class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(6){ Array.new(6) { "\u{25CB}" } }
    
  end

  def display_grid
    puts "#{grid[5]}"
    puts "#{grid[4]}"
    puts "#{grid[3]}"
    puts "#{grid[2]}"
    puts "#{grid[1]}"
    puts "#{grid[0]}"
  end

  def player_move
    empty_circle = "\u{25CB}"
    circle = 'circle'
    puts 'Pick column'
    x = gets.chomp.to_i
    y = 0   
    loop do
      if grid[y][x-1] == empty_circle
        grid[y][x-1] = circle
        return
      else
        y+=1
      end
    end
  end

  
end
