#!/usr/bin/env ruby

require './dfs.rb'
require 'gtk2'

window = Gtk::Window.new("Server")
window.set_default_size(300, 350)
window.signal_connect("delete_event") { false }
window.signal_connect("destroy") { Gtk.main_quit }

main_vbox = Gtk::VBox.new(false)

server_box = Gtk::HBox.new(false)
server = Gtk::Entry.new
server.width_chars=16
server.xalign=1
server.text="0.0.0.0"
colon = Gtk::Label.new(":")
port = Gtk::Entry.new
port.width_chars=4
port.xalign=1
port.text="8000"
server_box.pack_start server, true, true, 0
server_box.pack_start colon, false, false, 0
server_box.pack_start port, false, false, 0

redundancy_box = Gtk::HBox.new(false)
redundancy_label = Gtk::Label.new("Redundancy: ")
redundancy = Gtk::Entry.new
redundancy.width_chars=3
redundancy.xalign=1
redundancy.text="3"
connect = Gtk::Button.new("Start server")
redundancy_box.pack_start redundancy_label, false, false, 0
redundancy_box.pack_start redundancy, false, false, 0
redundancy_box.pack_start connect, true, true, 0

message_frame = Gtk::Frame.new("Messages")
message_box = Gtk::VBox.new(false)
message_scroll = Gtk::ScrolledWindow.new
messages = Gtk::TextView.new
message_scroll.add_with_viewport(messages)
message_box.pack_start message_scroll, true, true, 0
message_frame.add message_box

store_file_box = Gtk::HBox.new()
storage_label = Gtk::Label.new("Store file: ")
storage_file = Gtk::FileChooserButton.new("Filename", Gtk::FileChooser::ACTION_OPEN)
store_file_box.pack_start storage_label, false, false, 0
store_file_box.pack_start storage_file, true, true, 0

rebuild_file_box = Gtk::HBox.new()
rebuild_label = Gtk::Label.new("Filename: ")
rebuild_filename = Gtk::ComboBox.new()
rebuild_button = Gtk::Button.new("Rebuild")
delete_button = Gtk::Button.new("Delete")
rebuild_file_box.pack_start rebuild_label, false, false, 0
rebuild_file_box.pack_start rebuild_filename, true, true, 0
rebuild_file_box.pack_start rebuild_button, false, false, 0
rebuild_file_box.pack_start delete_button, false, false, 0

main_vbox.pack_start server_box, false, false, 0
main_vbox.pack_start redundancy_box, false, false, 0
main_vbox.pack_start message_frame, true, true, 0
main_vbox.pack_start store_file_box, false, false, 0
main_vbox.pack_start rebuild_file_box, false, false, 0

dht = nil

connect.signal_connect("clicked"){
	dht = DistributedFileStore.new(server.text, port.text.to_i)
	Thread.new{
		loop {
			messages.insert_at_cursor dht.message_queue.pop+"\n"
		}
	}
}

storage_file.signal_connect("file-set") {
	dht.store(storage_file.filename)
	rebuild_filename.append_text(storage_file.filename)
}

rebuild_button.signal_connect("clicked"){
	dht.rebuild(rebuild_filename.active_text)
}

delete_button.signal_connect("clicked"){
	dht.delete(rebuild_filename.active_text)
	rebuild_filename.remove_text(rebuild_filename.active)
}

window.add(main_vbox)
window.show_all
Gtk.main
