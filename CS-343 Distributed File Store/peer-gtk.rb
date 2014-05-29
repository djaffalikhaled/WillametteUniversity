#!/usr/bin/env ruby

require './peer.rb'
require 'gtk2'

window = Gtk::Window.new("Client")
window.set_default_size(300, 300)
window.signal_connect("delete_event") { false }
window.signal_connect("destroy") { Gtk.main_quit }

main_vbox = Gtk::VBox.new(false)

server_box = Gtk::HBox.new(false)
server = Gtk::Entry.new
server.width_chars=16
server.xalign=1
server.text="127.0.0.1"
colon = Gtk::Label.new(":")
port = Gtk::Entry.new
port.width_chars=4
port.xalign=1
port.text="8000"
connect_button = Gtk::Button.new("Connect")
server_box.pack_start server, true, true, 0
server_box.pack_start colon, false, false, 0
server_box.pack_start port, false, false, 0
server_box.pack_start connect_button, false, false, 0

message_frame = Gtk::Frame.new("Messages")
message_box = Gtk::VBox.new(false)

messages = Gtk::TextView.new
message_scroll = Gtk::ScrolledWindow.new
message_scroll.add_with_viewport(messages)
message_box.pack_start message_scroll, true, true, 0
message_frame.add message_box

main_vbox.pack_start server_box, false, false, 0
main_vbox.pack_start message_frame, true, true, 0

peer = nil

connect_button.signal_connect("clicked"){
	peer = Peer.new(server.text, port.text.to_i)
	Thread.new{
		loop{
			messages.insert_at_cursor peer.message_queue.pop+"\n"
		}
	}
}

window.add(main_vbox)
window.show_all
Gtk.main
