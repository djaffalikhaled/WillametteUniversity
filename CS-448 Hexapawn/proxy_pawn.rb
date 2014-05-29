#!/usr/bin/env ruby
require './graphics_library.rb'
require './game.rb'
include Gosu

#   These proxy pieces will stop drawing and updating when the linked pawn's confirm draw is turned back on
#	This class controls the clicked on pieces draw method, and controls the proxies lifespan. All piece movement is done in the controller.

class ProxyPawn
	attr_accessor :piece
	def initialize(window, x, y)
		@x, @y = x, y
		@window = window
		@piece = @window.game.board.get_piece_at_pixel(@x, @y, 0, 0)
		@hex_color = @piece.owner.hex_color - 0x44000000 + 0x00550000 # Reduces alpha value for transparency, increases red
		@piece.confirm_draw = false
		@proxy_shape = GraphicsLibrary::Triangle.new(window, @x, @y, window.game.board.cell_size, window.game.board.cell_size, @hex_color, 2)
	end
	
	
	def update
	# here we need to update the proxies x, y to mouse_x and mouse_y
		@proxy_shape.x, @proxy_shape.y = @window.mouse_x, @window.mouse_y
	end
	
	
	def draw
		@proxy_shape.draw if !@piece.confirm_draw
	end

	def on_mouse_up
		@piece.confirm_draw = true
	end
end
