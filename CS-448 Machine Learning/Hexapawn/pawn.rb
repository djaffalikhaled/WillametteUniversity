class Pawn
	attr_reader :color
	attr_reader :owner			# Instance of Player
	attr_accessor :confirm_draw
	attr_accessor :board
	
	def initialize(owner, board, shape, confirm_draw=true)
		@owner = owner					# so we can compare if another piece is ours or our oponent's
		@color = @owner.color			# so we know what color we are
		@board = board					# so we can ask the board what our local area is like
		@confirm_draw = confirm_draw	# so drawing can be turned off when moving a piece
		@shape = shape					# reference to the triangle for this pawn
	end

	def is_legal_move?(row,column)					# takes the row and column of the piece wants to move, returns if it can
		legal_moves = self.get_legal_moves			# get all legal moves (absolute positions on the board)
		return (legal_moves.include? [row,column])	# return if the suggested position was in that array
	end
	
	# swap the pieces location with the new row column
	# if there is an enemy in my own location, delete from board
	def move_to(row,column, update_draw=true)
		original_row, original_column = get_piece_location
		cell_old_contents = @board.board[row][column]
		@board.board[row][column] = self
		@board.board[original_row][original_column] = cell_old_contents
		@board.board[original_row][original_column] = nil if (cell_old_contents != nil) && (cell_old_contents.owner != @owner)
		@shape.x, @shape.y = @board.board_to_pixel(row,column,0,0) if update_draw
	end

	def get_legal_moves
		local_zone = get_local_zone
		return [] if local_zone[1] == :wall
		column_changes = []
		if @owner.board_side == :top
			row_change = 1
			column_changes << 0 if local_zone[1] == nil	
			column_changes << -1 if !([nil, :wall].include?(local_zone[2])) && local_zone[2].owner != @owner
			column_changes << 1 if !([nil, :wall].include?(local_zone[0])) && local_zone[0].owner != @owner
		elsif @owner.board_side == :bottom
			row_change = -1
			column_changes << 0 if local_zone[1] == nil	
			column_changes << 1 if !([nil, :wall].include?(local_zone[2])) && local_zone[2].owner != @owner
			column_changes << -1 if !([nil, :wall].include?(local_zone[0])) && local_zone[0].owner != @owner
		end
		possible_moves = []
		row,column = get_piece_location
		column_changes.each do |column_change|
			possible_moves << [row+row_change,column+column_change]
		end
		return possible_moves
	end
	
	def get_piece_location							# Given a piece, find its column and row
		piece_column = nil							# Initialize the column and row
		piece_row = nil
		@board.board.each_with_index do |column, i|	# For each column in the board
			if column.include? self					# If the piece is in this column
				return i, column.index(self)		# Return the column and row (index in the column) as soon as we find it to save time
			end
		end
	end
		
	def draw
		@shape.draw if @confirm_draw
	end
	
	#
	#	This method is rather long because we have to consider things from both sides of the board.
	#
	def get_local_zone															# Get all the spaces this pawn could move to
		board_side = @owner.board_side											# Find out which side of the board the player who owns this pawn started on
		pawn_column, pawn_row = get_piece_location								# Find out the column and row of the pawn
		upper_left = nil
		upper_right = nil
		if board_side == :top													# If we started on the top
			return [:wall, :wall, :wall] if pawn_column == @board.board.size-1	# We should return walls if we made it to the end
			direction = 1														# Our direction for calculating zone is 1
			if pawn_row == 0													# If we are moving down the left side
				upper_right = :wall												# Our upper right is out of bounds
			end
			if pawn_row == @board.board[0].size-1								# If we are moving down the right side
				upper_left = :wall												# Our upper left is out of bounds
			end
		elsif board_side == :bottom												# If we started on the bottom
			return [:wall, :wall, :wall] if pawn_column == 0					# Return walls if we started on the bottom and are now on the top
			direction = -1														# Our direction is -1
			if pawn_row == 0													# If we are moving up the left side
				upper_left = :wall												# Our upper left is out of bounds
			end
			if pawn_row == @board.board[0].size-1								# If we are moving up the right side
				upper_right = :wall												# Our upper right is out of bounds
			end
		end
		upper_left = @board.board[pawn_column+direction][pawn_row+direction] if upper_left != :wall		# If the left or right side weren't
		upper_middle = @board.board[pawn_column+direction][pawn_row]									# defined as :wall in the statement above
		upper_right = @board.board[pawn_column+direction][pawn_row-direction] if upper_right != :wall	# then they are on the board.
		return [upper_left,upper_middle,upper_right]
	end
end
