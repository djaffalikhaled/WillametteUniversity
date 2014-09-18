#!/usr/bin/env ruby

# We should be using a unit testing framework, but for time constraints lets use a script.
# We used these simple tests to make sure our board was stable.

require './board.rb'

def ensure_board_creates
	board = Board.new(3,3)
	return false if board.board.size != 3
	return false if board.board[0].size != 3
	return true
end

def ensure_clicks_correct
	board = Board.new(3,3)
	column,row = board.pixel_to_board(0,0,0,0,50)
	return false if (row != 0 || column != 0)
	column,row = board.pixel_to_board(50,50,0,0,50)
	return false if (row != 0 || column != 0)
	column,row = board.pixel_to_board(25,75,0,0,50)
	return false if (row != 0 || column != 1)
	column,row = board.pixel_to_board(125,125,0,0,50)
	return false if (row != 2 || column != 2)
	return true
end

def ensure_location_correct
	board = Board.new(3,3)
	x,y = board.board_to_pixel(0,0,0,0,100)
	return false if (x != 50 || y != 50)
	x,y = board.board_to_pixel(1,0,0,0,100)
	return false if (x != 50 || y != 150)
	x,y = board.board_to_pixel(0,1,0,0,100)
	return false if (x != 150 || y != 50)
	x,y = board.board_to_pixel(1,1,0,0,100)
	return false if (x != 150 || y != 150)
	x,y = board.board_to_pixel(2,2,0,0,100)
	return false if (x != 250 || y != 250)
	return true
end


puts "ensure_board_creates => #{ensure_board_creates}"
puts "ensure_clicks_correct => #{ensure_clicks_correct}"
puts "ensure_location_correct => #{ensure_location_correct}"
