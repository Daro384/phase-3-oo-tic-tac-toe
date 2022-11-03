class TicTacToe
    def initialize 
        @board = Array.new(9, " ")
    end

    WIN_COMBINATIONS = [
        [0,1,2], [3,4,5], [6,7,8], #rows
        [0,3,6], [1,4,7], [2,5,8], #columns
        [0,4,8], [2,4,6] #diagonals
    ]

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
      end

    def input_to_index(input)
        input.to_i - 1
    end

    def move (index, token = "X")
        @board[index] = token
    end

    def position_taken? (index)
        @board[index] != " "
    end
    
    def valid_move? (index)
        if position_taken?(index) 
            false
        elsif index < 0 
            false
        elsif index > 8 
            false
        else
            true
        end
    end

    def turn_count
        count = 0
        @board.each do |cell|
            count += 1 if cell != " "
        end
        count
    end

    def current_player
        turn_count % 2 == 0 ? "X" : "O"
    end

    def turn 
        while true
            puts "Play a move by entering a number from 1-9"
            input = gets.strip
            index = input_to_index(input)
            if valid_move? index
                move(index, current_player)
                display_board
                break
            end
        end
    end

    def won? 
        WIN_COMBINATIONS.each do |combination|
            x_matches = 0
            o_matches = 0
            combination.each do |cell_index|
                x_matches += 1 if @board[cell_index] == "X"
                o_matches += 1 if @board[cell_index] == "O"
            end
            if x_matches == 3 || o_matches == 3
                return true
            else
                x_matches = 0
                o_matches = 0
            end
        end
        false
    end

    def full?
        turn_count == 9
    end

    def draw? 
        full? && !won?
    end

    def over? 
        won? || draw?
    end

    def winner
        if over?
            turn_count % 2 == 1 ? "X" : "O"
        else
            nil
        end
    end

    def play
        turn while !over?
        puts won? ? "Congratulations #{winner}!" : "Cat's Game!"
    end
end