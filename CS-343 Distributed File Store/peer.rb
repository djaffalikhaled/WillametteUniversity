#!/usr/bin/env ruby

require 'socket'

class Peer

	attr_accessor :message_queue

	def initialize(server_ip, server_port)
		@server = TCPSocket.new(server_ip, server_port)
		@local_hash = {}
		Thread.new{ hold_chunks }
		@message_queue = Queue.new
		@message_queue << "Created new peer connecting to #{server_ip}:#{server_port}"
	end
	
	def hold_chunks
		loop {
			command = @server.gets.chomp
			command = command.split(" ")
			case command[0]
				when "INSERT"
					header = command[1].split(":")
					key = header[0]
					size = header[1].to_i
					data = @server.read(size)
					@local_hash.merge!(key => data)
					@message_queue << "INSERT #{key}"
				when "GET"
					key = command[1]
					data = @local_hash[key]
					@server.write(data)
					@message_queue << "GET #{key}"
				when "DELETE"
					key = command[1]
					@local_hash.delete(key)
					@message_queue << "DELETE #{key}"
			end
		}
	end
end
