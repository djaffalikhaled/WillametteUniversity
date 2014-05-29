require './board.rb'
require './players.rb'
require './minimax.rb'

# This class played X games of rote learner vs. rote learner.

class Trainer
	attr_reader :rote_learner
	def initialize(rote_learner, minimax_depth)
		@rote_learner = rote_learner
		@depth = minimax_depth
	end
	
	def do_match(size)
		board = Board.new(size,size)
		player1 = Player.new(:top, :white)
		player2 = Player.new(:bottom, :black)
		player1.board = board
		player2.board = board
		player1.fill_board
		player2.fill_board
		top_turn = (rand(2) == 1 ? true : false)
		last_top_board = nil
		last_bottom_board = nil
		until board.winner != nil
			puts @rote_learner.bad_states.size
			if top_turn
				move = @rote_learner.next_move(board, player1, last_top_board)
				break if move == :lost
				last_top_board = board.duplicate_board
				board.board[move[:old_row]][move[:old_column]].move_to(move[:new_row],move[:new_column])
				top_turn = false
			else
				move = @rote_learner.next_move(board, player2, last_bottom_board)
				#move = Minimaxer::next_move(board, player2, @depth)				# From when we were training against the minimaxer
				break if move == :lost
				last_bottom_board = board.duplicate_board
				board.board[move[:old_row]][move[:old_column]].move_to(move[:new_row],move[:new_column])
				top_turn = true
			end
		end
	end
end





