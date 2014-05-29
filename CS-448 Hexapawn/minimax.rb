class Minimaxer
	def self.next_move(board, player, depth)
		color = player.color
		tmp_board = board.duplicate_board
		best_board = minimax(tmp_board, color, depth, true)
		return :lost if board == nil || best_board[:board_state] == nil
		return diff(board.board, best_board[:board_state].board, color)
	end
	
	def self.minimax(board, color, depth, first_run, maximizing=true)
		if board.winner != nil
			if board.winner.color == color
				return {:board_state =>board,
						:value => 1}
			elsif board.winner.color != color
				return {:board_state => board,
						:value => -1}
			end
		end
		if depth == 0
			return {:board_state => board,
					:value => 0}
		end
		if maximizing
			best_board = nil
			best_value = (-1.0/0.0)
			all_boards = create_all_boards(board.duplicate_board, color, true)	# all moves that could happen from colors turn
			all_boards.each do |board|
				results = minimax(board.duplicate_board, color, depth-1, false, false)
				if results[:value] > best_value
					best_value = results[:value]
					best_board = results[:board_state]
				elsif results[:value] == best_value
					if rand(2) == 0
						best_board = results[:board_state]
					end
				end
			end
			return {:board_state => best_board, :value => best_value} if first_run
			return {:board_state => board, :value => best_value}
		else
			best_board = nil
			best_value = (1.0/0.0)
			all_boards = create_all_boards(board.duplicate_board, color, false)
			all_boards.each do |board|
				results = minimax(board.duplicate_board, color, depth-1, false, true)
				if results[:value] < best_value
					best_value = results[:value]
					best_board = results[:board_state]
				elsif results[:value] == best_value
					if rand(2) == 0
						best_board = results[:board_state]
					end
				end
			end
			return {:board_state => best_board, :value => best_value} if first_run
			return {:board_state => board, :value => best_value}
		end
	end

	def self.create_all_boards(board, color, turn)
		all_boards = []
		users = board.get_users_on_board
		if turn
			current_user = users[0] if users[0].color == color
			current_user = users[1] if users[1].color == color
		else
			current_user = users[0] if users[1].color == color
			current_user = users[1] if users[0].color == color
		end
		all_moves = current_user.get_all_moves
		all_moves.each do |move|
			old_row, old_column = move[:piece].get_piece_location
			tmp_board = board.duplicate_board
			tmp_board.board[old_row][old_column].move_to(move[:row],move[:column],false)
			all_boards << tmp_board
		end
		return all_boards
	end

	def self.print_board_state(board)
		board.each do |row|
			row.each do |piece|
				print "-" if piece == nil
				print "b" if piece != nil && piece.owner.color == :black
				print "w" if piece != nil && piece.owner.color == :white
			end
		puts
		end
	end
	
	def self.print_stateless_board_state(board)
		board.each do |row|
			row.each do |piece|
				print "-" if piece == nil
				print piece if piece != nil
			end
		puts
		end
	end
	
	def self.diff(old_board, new_board, color)
		old_row = nil
		old_column = nil
		new_row = nil
		new_column = nil
		old_board.each_with_index do |row, r|
			row.each_with_index do |piece, c|
				if (new_board[r][c] == nil) && (old_board[r][c] != nil && old_board[r][c].owner.color == color)
					old_row = r
					old_column = c
				end
				if (new_board[r][c] != nil && new_board[r][c].owner.color == color) && (old_board[r][c] == nil || old_board[r][c].owner.color != color)
					new_row = r
					new_column = c
				end
			end
		end
		return {:old_row => old_row,
				:old_column => old_column,
				:new_row => new_row,
				:new_column => new_column
		}
	end
end

