class Board
	attr_accessor :board
	attr_reader :cell_size
	
	def initialize(height, width,cell_size=100)	# Create a new board
		@board = []								# Start with an empty array
		height.times do |x|						# Use column major structure
			@board << Array.new(width, nil)		# to build array or rows
		end
		@cell_size = 100
		@board_graphics_overlay = []
		@stagger_cell_color_value = width		# For use in alternating board cell colors.
		@cell_size = cell_size
	end
	
	def winner				# This method checks ending conditions.  Returns nil (game ongoing) or the Player class that won
		@board[0].each do |piece|										# Lets check every piece on the top of the board
			if (piece != nil) && (piece.owner.board_side == :bottom)	# and see if someone from the bottom is there.
				return piece.owner										# If they made it, they won.
			end
		end
		@board[@board.size-1].each do |piece|							# Do the same for the bottom of the board
			if (piece != nil) && (piece.owner.board_side == :top)
				return piece.owner
			end					
		end
		all_users = get_users_on_board
		if all_users.size > 1
			return all_users[0] if !(all_users[0].has_no_moves?) && all_users[1].has_no_moves?
			return all_users[1] if !(all_users[1].has_no_moves?) && all_users[0].has_no_moves?
		else
			return all_users[0]
		end
		return nil
	end
	
	def get_users_on_board
		all_owners = []
		@board.each do |row|
			row.each do |piece|
				all_owners << piece.owner if piece != nil && !(all_owners.include? piece.owner)
			end
		end
		return all_owners
	end
	
	def get_piece_at_pixel(x,y,board_x,board_y)
		column, row = pixel_to_board(x,y,board_x,board_y)		# Get the click's position in board coordinates
		if column != :out_of_bounds && row != :out_of_bounds	# If out of bounds, column will be :out_of_bounds and row will be nil
			return @board[column][row]							# Otherwise it is safe to return what was there
		end
		return :out_of_bounds
	end
	
	def pixel_to_board(x,y,board_x,board_y)	# convert pixels returned by a mouse listener to a position on the board.
		# x is the x of the mouse
		# y is the y of the mouse
		# board_x is the x of the top left corner of the top left cell
		# board_y is the y of the top left corner of the top left cell
		# cell_width is the height/width of one square cell
		x -= board_x									# Adjust x and y values to start from the top left
		y -= board_y									# of the board as 0,0
		row = x.to_i / @cell_size						# How many times did we cross a cell in the x direction?
		row += 1 if (x % @cell_size) > 0				# We made it to the next one if we weren't exactly on the boarder.
		column = y.to_i / @cell_size					# Same calculation for y
		column += 1 if (y % @cell_size) > 0
		return :out_of_bounds if row > @board.size		# If the column is outside the board we are out of bounds
		return :out_of_bounds if column > @board[0].size# If the row is outside any (the top) row we are out of bounds
		row -= 1 if row > 0								# Adjust to count from 0 if needed
		column -= 1 if column > 0
		return column, row								# These calculations used 1,1 as the first cell, convert to an array ([0][0])
	end
	
	def board_to_pixel(column, row, board_x, board_y)
		x = 0					# Start by assigning x and y to zero
		y = 0
		column.times do |i|		# For each column it fully crosses
			y += @cell_size		# Add a cell's worth of distance in the y
		end
		row.times do |i|		# Same calculation for row in the x
			x += @cell_size
		end
		x += @cell_size/2		# Add the new piece to the center of the cell
		y += @cell_size/2
		x += board_x			# Offset the board if needed
		y += board_y
		return x,y
	end
	
	## Everything below here pertains to rendering the board using Gosu's window system. 
	
	def construct_board_graphics_overlay(window)
		dark = false								# this boolean controls the checkerboarding
		dark_hex = 0xff3f3333
		light_hex = 0xff9e9fad
		self.board.each_with_index do |column, c|
			column.size.times do |r|
				x = c*@cell_size
				y = r*@cell_size
				board_cell = GraphicsLibrary::Rectangle.new(window, x, y, @cell_size, @cell_size, dark_hex, 0) if dark
				board_cell = GraphicsLibrary::Rectangle.new(window, x, y, @cell_size, @cell_size, light_hex, 0) if !dark
				dark = !dark
				@board_graphics_overlay << board_cell					# append the cells to the array of cells.
			end
			dark = !dark if (@stagger_cell_color_value % 2 == 0)		# stagger the cell color for even sized boards so that it checkerboards properly.
				 
		end
	end
	
	def draw_pieces
		@board.each_with_index do |column, c|
			column.each_with_index do |piece, r|
				piece = self.board[c][r]
				piece.draw if piece != nil 
			end
		end
	end
	
	def draw
		@board_graphics_overlay.each do |cell|
			cell.draw
		end
	end
	
	#
	# This method is used by the computer players
	# It copies a new version of each player, pawn, and board
	#
	def duplicate_board
		tmp_board = Board.new(@board.size,@board.size)
		all_users = get_users_on_board
		player1 = Player.new(all_users[0].board_side, all_users[0].color)
		player1.board = tmp_board
		if all_users.size > 1
			player2 = Player.new(all_users[1].board_side, all_users[1].color)
			player2.board = tmp_board
		end
		@board.each_with_index do |row, r|
			row.each_with_index do |pawn, c|
				if pawn != nil
					if pawn.owner == all_users[0]
						tmp_board.board[r][c] = Pawn.new(player1, tmp_board, nil, false)
					elsif pawn.owner == all_users[1]
						tmp_board.board[r][c] = Pawn.new(player2, tmp_board, nil, false)
					end
				else
					tmp_board.board[r][c] = nil
				end
			end
		end
		return tmp_board
	end
end
