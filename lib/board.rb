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
    y = 0   
    loop do
      x = gets.chomp.to_i
      move = move_processes(y,x)
      return move if !move.nil?

    end
  end

  def move_processes(y,x)
    if grid[y][x-1] == @empty_circle
      grid[y][x-1] = @move_status == false ? @first_players_symbol : @second_player_symbol
      switch_status
      return
    else
      y+=1
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

end