#!/usr/bin/env ruby

#
# This is the main gtk window used to create new games and train the rote learner.
#

require 'gtk2'
require './gameboard.rb'
require './rote_learner.rb'
require './trainer.rb'
require './players.rb'

window = Gtk::Window.new("Hexapawn")
window.signal_connect("destroy") { Gtk.main_quit }

@rote_learner = RoteLearner.new

def display_message(title, message)
	dialog = Gtk::Dialog.new(title)
	dialog.signal_connect('response') { dialog.destroy }
	dialog.vbox.add(Gtk::Label.new(message))
	dialog.show_all
end

def display_winner(winner)
	winner = "Nobody" if winner == ""
	dialog = Gtk::Dialog.new("Game over")
	dialog.signal_connect('response') { dialog.destroy }
	dialog.vbox.add(Gtk::Label.new("#{winner} has won the game"))
	dialog.show_all
end

def train_rote_learner(games, depth, size)
    dialog = Gtk::Dialog.new("Training")
    training_bar = Gtk::ProgressBar.new
    dialog.vbox.add(training_bar)
    dialog.show_all
	trainer = Trainer.new(@rote_learner, depth)
	games.times do |i|
		trainer.do_match(size)
		begin
			training_bar.set_fraction (i.to_f/games)
		rescue
			break
		end
		while Gtk.events_pending?
			Gtk.main_iteration
		end
	end
	begin
	dialog.destroy
	rescue; end
end

stack = Gtk::VBox.new(false, 5)
minimax_settings = Gtk::Frame.new("Minimax settings")
rote_settings = Gtk::Frame.new("Rote settings")


white_frame = Gtk::Frame.new("White (First player)")
white_type = Gtk::ComboBox.new()
white_type.append_text("Human")
white_type.append_text("Rote Learner")
white_type.append_text("Minimax")
white_type.set_active 0
white_frame.add white_type

black_frame = Gtk::Frame.new("Black (Second player)")
black_type = Gtk::ComboBox.new()
black_type.append_text("Human")
black_type.append_text("Rote Learner")
black_type.append_text("Minimax")
black_type.set_active 0
black_frame.add black_type

game_control = Gtk::HBox.new(false, 5)
size_label = Gtk::Label.new("Size:")
board_size = Gtk::Entry.new
board_size.xalign=1
board_size.width_chars=4
board_size.insert_text("3", 0)
cell_size_label = Gtk::Label.new("Cell Size:")
cell_size = Gtk::ComboBox.new
cell_size.append_text("Small")
cell_size.append_text("Medium")
cell_size.append_text("Large")
cell_size.set_active 1
start_game = Gtk::Button.new("Start")
minimax_depth = nil
start_game.signal_connect("clicked"){
	board_dimensions = board_size.text.to_i
	case cell_size.active
		when 0
			cell_dimension = 80
		when 1
			cell_dimension = 100
		when 2
			cell_dimension = 150
	end
	if (white_type.active != 0)  && (black_type.active != 0 )
		display_message("Error", "One player needs to be human, to train a rote learner see more options below.")
	else
	case black_type.active
		when 0
			player1 = Player.new(:top, :black, 1, false)
		when 1
			player1 = Player.new(:top, :black, 1, :rote)
		when 2
			player1 = Player.new(:top, :black, 1, :minimax)
	end
	case white_type.active
		when 0
			player2 = Player.new(:bottom, :white, 1, false)
		when 1
			player2 = Player.new(:bottom, :white, 1, :rote)
		when 2
			player2 = Player.new(:bottom, :white, 1, :minimax)
	end
	$game_winner = nil
	window = GameWindow.new(board_dimensions, cell_dimension, @rote_learner, minimax_depth.text.to_i, player1, player2)
	window.show
	display_winner($game_winner.to_s)
	end
}
game_control.pack_start size_label, false, false, 0
game_control.pack_start board_size, false, false, 0
game_control.pack_start cell_size_label, false, false, 0
game_control.pack_start cell_size, false, false, 0
game_control.pack_start start_game, true, true, 0

minimax_line = Gtk::HBox.new(false, 5)
minimax_depth_label = Gtk::Label.new("Minimax depth:")
minimax_depth = Gtk::Entry.new
minimax_depth_label = Gtk::Label.new("Minimax depth:")
minimax_depth.width_chars=7
minimax_depth.xalign=1
minimax_depth.insert_text("4", 0)
reset_rote_button = Gtk::Button.new("Reset rote player")
reset_rote_button.signal_connect("clicked"){
	@rote_learner = RoteLearner.new
}
minimax_line.pack_start minimax_depth_label,false, false, 0
minimax_line.pack_start minimax_depth, false, false, 0
minimax_line.pack_start reset_rote_button, true, true, 0

training_bar = Gtk::HBox.new(false, 0)
training_label_front = Gtk::Label.new("Train rote learner for ")
training_amount = Gtk::Entry.new
training_amount.width_chars=3
training_amount.insert_text("100", 0)
training_label_back = Gtk::Label.new(" games. ")
training_button = Gtk::Button.new("Begin training")
training_button.signal_connect("clicked"){
	train_rote_learner(training_amount.text.to_i, minimax_depth.text.to_i, board_size.text.to_i)
}
training_bar.pack_start training_label_front, false, false, 0
training_bar.pack_start training_amount, false, false, 0
training_bar.pack_start training_label_back, false, false, 0
training_bar.pack_start training_button, true, true, 0


load_line = Gtk::HBox.new(false, 0)
load_label = Gtk::Label.new("Load saved rote tree: ")
load_button = Gtk::FileChooserButton.new("Input", Gtk::FileChooser::ACTION_OPEN)
load_button.signal_connect("file-set") {
	@rote_learner.load_from_file(load_button.filename)
}
load_line.pack_start load_label, false, false, 0
load_line.pack_start load_button, true, true, 0

save_line = Gtk::HBox.new(false, 5)
save_label = Gtk::Label.new("Save rote tree:")
save_filename = Gtk::Entry.new
save_filename.xalign=1
save_filename.insert_text("rote_state.rlf", 0)
save_button = Gtk::Button.new("Save")
save_button.signal_connect("clicked"){
	@rote_learner.write_to_file(save_filename.text)
}
save_line.pack_start save_label, true, true, 0
save_line.pack_start save_filename, true, true, 0
save_line.pack_start save_button, true, true, 0

expander = Gtk::Expander.new("More Options", true)
expander.signal_connect("notify::expanded"){
  if expander.expanded?
     minimax_settings.show
     rote_settings.show
  else
     minimax_settings.hide
     rote_settings.hide
  end
}

stack.pack_start white_frame, false, false, 0
stack.pack_start black_frame, false, false, 0
stack.pack_start game_control, false, false, 0
stack.pack_start expander, false, false, 0

minimax_settings_vbox = Gtk::VBox.new(false, 0)
minimax_settings_vbox.pack_start minimax_line, false, false, 0
minimax_settings_vbox.pack_start training_bar, false, false, 0
minimax_settings.add minimax_settings_vbox
stack.pack_start minimax_settings, false, false, 0

rote_settings_vbox = Gtk::VBox.new(false, 0)
rote_settings_vbox.pack_start load_line, false, false, 0
rote_settings_vbox.pack_start save_line, false, false, 0
rote_settings.add rote_settings_vbox
stack.pack_start rote_settings, false, false, 0

window.add(stack)
window.show_all
minimax_settings.hide
rote_settings.hide
Gtk.main
