#!/usr/bin/env ruby
# Implement TicTacToe Game Interface

class TicTacToe
    def initialize
      @position = [1, 2, 3, 4, 5, 6, 7, 8, 9]
      @count = 0
      puts 'Enter First Player name: '
      @name1 = gets.chomp
      puts 'Enter Second Player name: '
      @name2 = gets.chomp
      @player1 = 'X'
      @player2 = 'O'
      puts "#{@name1} is #{@player1}"
      puts "#{@name2} is #{@player2}"
    end
  
    def draw_board
      if @count == 9
        @position = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        @count = 0
      end
      puts "|  #{@position[6]}  |  #{@position[7]}  |  #{@position[8]} |"
      puts '------------------'
      puts "|  #{@position[3]}  |  #{@position[4]}  |  #{@position[5]} |"
      puts '------------------'
      puts "|  #{@position[0]}  |  #{@position[1]}  |  #{@position[2]} |"
      puts '------------------'
    end
  
    # rubocop:disable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity
  
    def player_turn
      draw_board
      loop do
        player = if @count.even?
                   @name1
                 else
                   @name2
                 end
        puts "#{player} Make a move? Choose between 1-9"
        move = gets.chomp.strip.to_i
        update_board(move)
        @count += 1
        break if win?(player)
        break if draw?
      end
    end
  
    def update_board(move)
      if move >= 1 && move <= 9
        if @position[move - 1] != @player1 && @position[move - 1] != @player2 # If not already taken
          if @count.even?
            @position[move - 1] = @player1
          elsif @count.odd?
            @position[move - 1] = @player2
          end
        else
          puts 'Already taken, Make another move'
          @count -= 1
        end
      else
        puts 'Invalid move'
        @count -= 1
      end
      draw_board
    end
  
    def win?(player)
      if @count.odd?
        player = @player1
        name = @name1
      else
        player = @player2
        name = @name2
      end
  
      if [@position[0], @position[1], @position[2]].all?(player) ||
         [@position[0], @position[4], @position[8]].all?(player) ||
         [@position[0], @position[3], @position[6]].all?(player) ||
         [@position[1], @position[4], @position[7]].all?(player) ||
         [@position[2], @position[4], @position[6]].all?(player) ||
         [@position[2], @position[5], @position[8]].all?(player) ||
         [@position[6], @position[7], @position[8]].all?(player) ||
         [@position[3], @position[4], @position[5]].all?(player)
        puts "Congratulations #{name}, you won!!!"
        true
      end
    end
  
    # rubocop:enable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity
  
    def play_again
      puts 'Do you want to play again? y or n'
      response = gets.chomp.strip.downcase
      if response == 'y'
        player_turn
      else
        puts 'Game Over!!!'
      end
    end
  
    def draw?
      return unless @count == 9
  
      ((@position.include? @player1) || @player2)
      check_draw = true
      puts 'Its a tie!!!'
      play_again
      check_draw
    end
  end
  
  # Display the Board
  
  play = TicTacToe.new
  play.player_turn
  