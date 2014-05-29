require './board.rb'
require './players.rb'
require './minimax.rb'

class RoteLearner
	attr_accessor :bad_states
	def initialize
		@bad_states = {}
	end
	
	def write_to_file(filename)
		File.open(filename,'wb') { |file| file.write Marshal.dump(@bad_states) }
	end
	
	def load_from_file(filename)
		@bad_states = Marshal.load(File.binread(filename))
	end
	
	def mirror(array)
		final_array = []
		array.each do |row|
			final_array << row.reverse
		end
		return final_array
	end
	
	def	stateless(board, color)
		stateless_board = []
		board.board.size.times do |i|
			stateless_board << Array.new(board.board.size,nil)
		end
		board.board.each_with_index do |row, r|
			row.each_with_index do |piece, c|
				if board.board[r][c] != nil
					if board.board[r][c].owner.color == color
						stateless_board[r][c] = "y"
					else
						stateless_board[r][c] = "n"
					end
				end
			end
		end
		return stateless_board
	end
	
	def next_move(starting_board, player, previous_board)
		final_board = nil
		board = starting_board.duplicate_board
		all_boards = Minimaxer::create_all_boards(board, player.color, true)
		good_moves = []
		all_boards.each do |possible_board|
			return Minimaxer::diff(board.board, possible_board.board, player.color) if possible_board.winner != nil && possible_board.winner.color == player.color	# Take any winning move immediatly
			if !is_bad_board?(possible_board, player)
				good_moves << possible_board
			end
		end
		if good_moves.size == 0
			add_board(previous_board, player) if board.winner != player
			return :lost if all_boards.size == 0
			final_board = all_boards.sample
		else
			final_board = good_moves.sample
		end
		return Minimaxer::diff(board.board, final_board.board, player.color)
	end
	
	def print_bad_boards
		@bad_states.each do |k,v|
			Minimaxer::print_stateless_board_state(Marshal.load(k))
			puts "\n\n"
		end
	end
	
	def add_board(board, player)
		@bad_states.merge!(Marshal.dump(stateless(board, player.color)) => :bad_board)
		@bad_states.merge!(Marshal.dump(mirror(stateless(board, player.color))) => :bad_board)
	end
	
	def is_bad_board?(board, player)
		return @bad_states[Marshal.dump(stateless(board, player.color))] == :bad_board
	end
end
