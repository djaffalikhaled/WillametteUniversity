require './pawn.rb'
require './graphics_library.rb'

# Players are aware of their color and own pawns.  All they do is fill out their board and are used as references in other classes.

class Player
	attr_reader :color				# so the Pawns can ask which char they are
	attr_accessor :board			# so the game constructor can assign the board
	attr_reader :board_side			# so the board knows the forward direction when getting the local zone of a pawn
	attr_writer :window
	attr_accessor :hex_color
	attr_accessor :is_bot
	
	def initialize(board_side, color, placement_depth=1, is_bot=false)
		@board = nil							# will be assigned when passed to a game constructor with a Board
		@board_side = board_side				# the side to start from, :top or :bottom
		@color = color							# the color the piece will draw as, :black or :white
		@placement_depth = placement_depth		# how many rows to fill into the board (experimental additional feature)
		@window = nil
		if @color == :black
			@hex_color = 0xff000000
		elsif @color == :white
			@hex_color = 0xffffffff
		end
		@is_bot = is_bot
	end
		
	def fill_board	# place your pieces on their starting conditions on the board
		cell_size = @board.cell_size
		@placement_depth.times do |i|
			passed = 0
			if @board_side == :top
				@board.board[i].each_with_index do |cell, j|
					x, y = @board.board_to_pixel(i,j,0,0)
					shape = GraphicsLibrary::Triangle.new(@window, x, y, cell_size, false, @hex_color, 1)
					@board.board[i][j] = Pawn.new(self, @board, shape)
				end
			elsif @board_side == :bottom
				@board.board.reverse.each_with_index do |cell, j|
					i = @board.board.size-1-passed
					x, y = @board.board_to_pixel(i,j,0,0)
					shape = GraphicsLibrary::Triangle.new(@window, x, y, cell_size, false, @hex_color, 1)
					@board.board[i][j] = Pawn.new(self, @board, shape)
				end
			end
			passed += 1
		end
	end
	
	#
	# Will return true if there is nothing this player can do on the board.
	#
	def has_no_moves?
		@board.board.each do |row|
			row.each do |piece|
				if (piece != nil) && (piece.owner == self)
					return false if piece.get_legal_moves.size > 0
				end
			end
		end
		return true
	end
	
	def get_all_moves
		all_moves = []
		@board.board.each do |row|
			row.each do |piece|
				if (piece != nil) && (piece.owner == self)
					piece.get_legal_moves.each do |move|
						all_moves << {:piece => piece, :row => move[0], :column => move[1]}
					end
				end
			end
		end
		return all_moves
	end
end
