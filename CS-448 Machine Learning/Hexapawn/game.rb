require './board.rb'
require './graphics_library.rb'
require 'gosu'
require './minimax.rb'
include Gosu

# The game class that the game window directly interacts with.

class Game
	attr_reader :board
	attr_accessor :current_player
	attr_accessor :standby_player
	attr_accessor :selected_piece
	attr_accessor :rote_learner
	attr_accessor :minimax_depth
	
	def initialize(board_size,player1,player2,window,cell_size=100,rote_learner,depth)
		@window = window
		@cell_size = cell_size
		@board = Board.new(board_size,board_size,@cell_size)
		@player1 = player1
		@player2 = player2
		@player1.board = @board
		@player2.board = @board
		@player1.fill_board
		@player2.fill_board
		@current_player = (@player1.color == :white ? @player1 : @player2)
		@standby_player = (@current_player == @player1 ? @player2 : @player1)
		@selected_piece = nil
		@rote_learner = rote_learner
		@minimax_depth = depth
		@last_cpu_board = nil
		cpu_controller if @current_player.is_bot != false
	end
	
	def cpu_controller
		if @current_player.is_bot == :minimax
			move = Minimaxer::next_move(@board, @current_player, @minimax_depth)
		elsif @current_player.is_bot == :rote
			move = @rote_learner.next_move(@board, @current_player, @last_cpu_board)
		end
		begin
		@board.board[move[:old_row]][move[:old_column]].move_to(move[:new_row],move[:new_column]) 
		rescue
		end
		winner = check_winner
		if winner == nil
			switch_player
		else
			$game_winner = winner.color
			sleep 0.5
			@window.close
		end
	end
	
	
	## Controller is called in this state:
	## the piece.owner = current_player
	## @selected_piece = piece user clicked on initially
	def controller
		temp_board = @board.duplicate_board
		@last_cpu_board = @board.duplicate_board
		return nil if current_player.is_bot != false
		row, column = @board.pixel_to_board(@window.mouse_x, @window.mouse_y, 0, 0)
		return nil if !@selected_piece.is_legal_move?(row, column)
		temp_board = @board.duplicate_board
		@selected_piece.move_to(row, column)
		winner = check_winner
		if winner == nil
			switch_player
		else
			$game_winner = winner.color
			if @current_player.color == winner.color
				if @standby_player.is_bot == :rote
					@rote_learner.add_board(@last_cpu_board, @standby_player)
				end 
			elsif @standby_player.color == winner.color
				if @current_player.is_bot == :rote
					@rote_learner.add_board(@last_cpu_board, @current_player)
				end
			end
			sleep 0.5
			@window.close
		end
		puts @rote_learner.bad_states.size
		cpu_controller if @current_player.is_bot != false
		@selected_piece = nil
	end
	
	def check_winner
		if @board.winner != nil
			return @board.winner
		end
		if @current_player.has_no_moves?
			if @standby_player.has_no_moves?
				return @current_player
			else
				return @standby_player
			end
		end
	end
	
	def switch_player
		@current_player, @standby_player = @standby_player, @current_player
	end
end

