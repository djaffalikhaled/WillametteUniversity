require 'socket'
require 'thread'
require './file_store.rb'
require './node.rb'

class DistributedFileStore
	attr_accessor :message_queue
	attr_reader :stored_files

	def initialize(server_ip, server_port)
		@server = TCPServer.new(server_ip,server_port)
		@all_filestores = []
		@stored_files = {}
		@all_nodes = []
		@message_queue = Queue.new
		@message_queue << "Created new distributed file store"
		Thread.new{ accept_nodes }
	end

	def accept_nodes
		loop {
			@all_nodes << Node.new(@server.accept)
			@all_filestores.each { |store| store.all_nodes = @all_nodes }
			@message_queue << "New node has connected to data store"
		}
	end

	def store(filename)
		new_store = FileStore.new(filename, @all_nodes)
		@all_filestores << new_store
		@stored_files.merge!(filename => new_store)
		@message_queue << "Stored new file: #{filename}"
	end
	
	def rebuild(filename)
		store = @stored_files[filename]
		if store == nil
			@message_queue << "Asked to rebuld #{filename}, not currently stored"
			return
		end
		store.rebuild_file(filename)
		@message_queue << "Rebuilt file #{filename}"
	end
	
	def delete(filename)
		store = @stored_files[filename]
		if store == nil
			@message_queue << "Asked to delete #{filename}, not currently stored"
			return
		end
		store.delete_file
		@message_queue << "Deleted file #{filename}"
	end
end
