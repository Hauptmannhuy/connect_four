class Board
  attr_reader :grid, :move_status

  def initialize
    @grid = Array.new(6){ Array.new(6) { "\u{25CB}" } }
    @move_status = false
    @first_player_symbol = '0'
    @second_player_symbol
  end

  def display_grid
    puts "#{grid[5]}"
    puts "#{grid[4]}"
    puts "#{grid[3]}"
    puts "#{grid[2]}"
    puts "#{grid[1]}"
    puts "#{grid[0]}"
  end

  def switch_status
    @move_status = @move_status == false ? true : false
  end

  def player_move
    empty_circle = "\u{25CB}"
    puts 'Pick column'
    x = gets.chomp.to_i
    y = 0   
    loop do
      if grid[y][x-1] == empty_circle
        grid[y][x-1] = @first_player_symbol
        switch_status
        return
      else
        y+=1
      end
    end
  end

  
end
