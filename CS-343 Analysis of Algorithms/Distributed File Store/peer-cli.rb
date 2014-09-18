#!/usr/bin/env ruby

require './peer.rb'

if ARGV.size != 2
	puts "Usage:"
	puts "./peer-cli.rb <server:port> <number of peers>"
	exit
end

server, port = ARGV[0].split(":")
port = port.to_i
count = ARGV[1].to_i

peers = []

count.times do |i|
	peers << Peer.new(server, port)
end

threads = []

peers.each do |peer|
	threads << Thread.new{ loop { puts peer.message_queue.pop } }
end

threads.each do |thread|
	thread.join
end
