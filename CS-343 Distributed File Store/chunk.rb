require 'digest'

class Chunk

	attr_accessor :nodes

	def initialize(data, nodes)
		@nodes = nodes
		@hash = Digest::SHA1.hexdigest data
		@nodes.each do |node|
			node.store(@hash, data)
		end
		Thread.new{ ping_peers }
	end
	
	def retrieve_data
		@nodes.each do |node|
			begin
				data = node.get(@hash)
				return data
			rescue
				@nodes.delete node
			end
		end
		raise "No connections to my data!"
	end
	
	def insert_new_node(node)
		node.usage += 1
		@nodes << node
		data = retrieve_data
		node.store(@hash, data)
	end
	
	def delete
		@nodes.each do |node|
			node.delete(@hash)
		end
	end
	
	def ping_peers
		loop {
			@nodes.each do |node|
				@nodes.delete node if !node.is_alive?
			end
			sleep 3
		}
	end
end
