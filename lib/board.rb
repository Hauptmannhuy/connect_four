require 'colorize'

class Board
  attr_reader :grid, :move_status

  def initialize
    @empty_circle = "\u{25CB}"
    @first_player_symbol = "\u{25CF}".blue
    @second_player_symbol = "\u{25CF}".red
    @grid = Array.new(6){ Array.new(6) { @empty_circle } }
    @move_status = false
    @last_visited
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
    y = 0   
    x = enter_input 
    move_processes(y,x)
  end

  def move_processes(y,x)
    loop do
    if grid[y][x] == @empty_circle
      grid[y][x] = @move_status == false ? @first_player_symbol : @second_player_symbol
      @last_visited = [y,x]
      # switch_status
      return
    else
      y+=1
    end
  end
end

  def enter_input
    loop do
      puts "Select column."
      input = gets.chomp.to_i
      if input.between?(1,6)
      verify_input = input_validation(input)
      return verify_input if verify_input
      else
        puts "Input should only be between 1-6!"
      end
    end
  end

  def input_validation(input)
   
    input = input-1
    if !column_full?(input)
        return input
      else
        puts 'This column is already full!'
      end
  end

  def column_full?(num)
    array = []
    i = 0
    6.times do
      array << @grid[i][num]
      i+=1
      end
       array.all?{| el | el != @empty_circle}
  end

  def test
    changed_grid = self.instance_variable_get(:@grid)
    i = 0
    3.times do
      changed_grid[0][i] = @first_player_symbol
      i+=1
      end
    self.instance_variable_set(:@grid, changed_grid)
    
  end

  def check_horizontal
    y,x = @last_visited
    grid = @grid
    marker = @move_status == false ? @first_player_symbol : @second_player_symbol
    return true if grid[y][x+1] == marker && grid[y][x+2] == marker && grid[y][x+3] == marker
    return true if grid[y][x-1] == marker && grid[y][x+1] == marker && grid[y][x+2] == marker
    return true if grid[y][x-2] == marker && grid[y][x-1] == marker && grid[y][x+1] == marker
    return true if grid[y][x-3] == marker && grid[y][x-2] == marker && grid[y][x-1] == marker
    false
  end

  def check_vertical
    y,x = @last_visited
    grid = @grid
    marker = @move_status == false ? @first_player_symbol : @second_player_symbol
    return true if grid[y+1][x] == marker && grid[y+2][x] == marker && grid[y+3][x] == marker
    false
  end
  
end

board = Board.new




board.player_move
board.display_grid
