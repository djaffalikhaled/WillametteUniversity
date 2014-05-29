class Node
  attr_accessor :next_node
  attr_accessor :usage
  
	def initialize(socket)
		@socket = socket
		@next_node = nil
		@size_map = {}
		@usage = 0
	end
	
	def is_alive?
		begin
			@socket.puts "PING"
			return true
		rescue
			return false
		end
	end
  
	def store(key, data)
		size = data.size
		@size_map.merge!(key => size)
		@socket.puts "INSERT #{key}:#{size}"
		@socket.write(data)
	end
  
	def get(key)
		@socket.puts "GET #{key}"
		return @socket.read(@size_map[key])
	end
  
	def delete(key)
		@socket.puts "DELETE #{key}"
	end
end
