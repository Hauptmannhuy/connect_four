require 'colorize'

class Board
  attr_reader :grid, :move_status

  def initialize
    @empty_circle = "\u{25CB}"
    @first_players_symbol = "\u{25CF}".blue
    @second_player_symbol = "\u{25CF}".red
    @grid = Array.new(6){ Array.new(6) { @empty_circle } }
    @move_status = false
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
    puts 'Pick column'
    x = gets.chomp.to_i
    y = 0   
    loop do
      if grid[y][x-1] == @empty_circle
        grid[y][x-1] = @move_status == false ? @first_players_symbol : @second_player_symbol
        switch_status
        return
      else
        y+=1
      end
    end
  end

  
end
