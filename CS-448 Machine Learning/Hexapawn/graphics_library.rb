require 'gosu'
include Gosu

# This is a wrapper for the Gosu Graphics Engine
# To build a wrapper, give attr_accessor's for all variables required in initialize.
# These functions need access to Gosu's window system, so pass it in your constructor!
# 
# class yourClass
# 	def initialize(window, your attributes here)
#	
#	def draw(window)
#		@window.__gosu_draw_function_name___(required gosu drawing inputs here)
#  


module GraphicsLibrary

	class Rectangle
		attr_accessor :x		# the x coordinate of the center of the rectangle
		attr_accessor :y		# the y coordinate of the center of the rectangle
		attr_accessor :width	# the width of the rectangle
		attr_accessor :height	# the height of the rectangle
		attr_accessor :color	# defaults to 0xffff0000 (red)
		attr_accessor :z_order	# the draw order of this object (0 is first)
		
		def initialize(window, x, y, width, height, color=0xffff0000, z_order=0)
			@window = window
			@x = x
			@y = y
			@width = width
			@height = height
			@color = color
			@z_order = z_order	
		end

		def draw
			@window.draw_quad(@x, @y, @color, @x+@width, @y, @color, @x, @y+@height, @color, @x+@width, @y+@height, @color, @z_order) 
		end
		
	end
	
	class Triangle
		attr_accessor :x		# the x coordinate of the center of the triangle
		attr_accessor :y		# the y coordinate of the center of the triangle
		attr_accessor :radius	# the distance of each point from the center
		attr_accessor :flip		# boolean true/false
		attr_accessor :color	# defaults to 0xffff0000 (red)
		attr_accessor :z_order	# the draw order of this object.
		
		def initialize(window, x, y, radius, flip=false, color=0xffff0000, z_order=0)
			@window = window
			@x = x
			@y = y
			@radius = radius
			@color = color
			@z_order = z_order
			@flip = flip
			@height = Math::sin(60)*@radius
			@length = Math::sin(30)*@radius	
			convertVertices
		end
		
		def convertVertices
			# C is the top point in the triangle
			@cx = @x
			@cy = @y-(@radius/2)
			# A is the bottom left
			@ax = @x-(@length/2)
			@ay = @y+(@radius/2)
			# B is the bottom right
			@bx = @x+(@length/2)
			@by = @y+(@radius/2)
		end
		
		def update
			convertVertices
		end
		
		def print_debug
			puts "Center => (#{@x},#{@y}) bot left => (#{@ax},#{@ay}) bot right => (#{@bx},#{@by}) top => (#{@cx},#{@cy})"
		end
		
		def draw
			update
			@window.draw_triangle(@bx, @by, @color, @ax, @ay, @color, @cx, @cy, @color, @z_order)

		end
	end
	
end





