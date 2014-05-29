#!/usr/bin/env ruby

require './graphics_library.rb'
require './game.rb'
require './players.rb'
require './proxy_pawn.rb'

# This class inherited from our graphics libraries window class and draws the games.

class GameWindow < Gosu::Window
	attr_accessor :game 			# proxy pieces need to have access to the game pieces b/c they control its drawing
	attr_accessor :mouse_pressed

	def initialize(board_size=3, cell_size=100, rote_learner, depth, player1, player2)
		@board_size = board_size
		super @board_size*cell_size, @board_size*cell_size, false
		self.caption = "Hexpawn"
		player1.window = self
		player2.window = self
		@game = Game.new(@board_size, player2, player1, self, cell_size, rote_learner, depth)
		@game.board.construct_board_graphics_overlay(self)
		@mouse_resting = true
		@resting_cursor = Gosu::Image.new(self, "images/resting.png", false)
		@grabbing_cursor = Gosu::Image.new(self, "images/grabbing.png", false)
		@mouse_pressed = false 
		@does_proxy_exist = false
	end
	
	def update
		# Update the proxy triangle if a piece was selected
		@proxy.update if @proxy != nil
	end

	def draw
		# Draw Board
		@game.board.draw_pieces  
		@game.board.draw
		
		# Draw Proxy if it exists
		@proxy.draw if @proxy != nil
		
		# Draw cursor depending on mouse_resting true/false
		@resting_cursor.draw(mouse_x, mouse_y, 2) if @mouse_resting
		@grabbing_cursor.draw(mouse_x, mouse_y, 2) if !@mouse_resting
	end

	def button_down(id)
		if id == Gosu::KbEscape
			close
		end
		
		if id == Gosu::MsLeft
			@mouse_pressed, @mouse_resting  = true, false
			row,column = @game.board.pixel_to_board(mouse_x,mouse_y,0,0)
			pawn = @game.board.board[row][column]
			if pawn == nil
		#		puts "No piece selected"
			elsif @game.current_player != pawn.owner
		#		puts "It is not your turn"
			else
				@game.selected_piece = pawn
				@proxy = ProxyPawn.new(self, mouse_x, mouse_y)
				@does_proxy_exist = true
			end
		end
	end
  
	def button_up(id)
		if id == Gosu::MsLeft
			@mouse_pressed,@mouse_resting  = false, true
			if @game.selected_piece != nil
				@proxy.on_mouse_up
				game.controller		# Game Controller should only be called if the user clicked on a piece that is theirs
			end
			@does_proxy_exist = false
		end
	end
end
