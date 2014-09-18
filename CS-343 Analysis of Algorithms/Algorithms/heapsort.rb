#!/usr/bin/env ruby

# Hayden Parker
# Febuary 13th, 2014
# CS-343 Analysis of Algorithms

class Array
	def heapsort!
		@heap_size = 0
		build_max_heap!
		self.size.downto(1) do |i|
			swap!(0, i-1)
			@heap_size -= 1
			max_heapify!(0)
		end
		self
	end
	
	def heapsort
		tmp = self
		tmp.heapsort!
		tmp
	end
	
	private

	def build_max_heap!
		@heap_size = self.size-1
		((self.size.to_f/2.to_f).to_i).downto(0) do |i|
			max_heapify! i
		end
	end
	
	def max_heapify!(i)
		left_index = heap_left_node_index(i)
		right_index = heap_right_node_index(i)
		left_value = self[left_index]
		right_value = self[right_index]
		left_value = (-1.0/0.0) if left_value == nil
		right_value = (-1.0/0.0) if right_value == nil
		if ((left_index <= @heap_size) and (left_value > self[i]))
			largest = left_index
		else
			largest = i
		end
		if ((right_index <= @heap_size) and (right_value > self[largest]))
			largest = right_index
		end
		if largest != i
			swap!(i, largest)
			max_heapify!(largest)
		end
	end
	
	def swap!(a,b)
		self[a], self[b] = self[b], self[a]
		self
	end
	
	def heap_left_node_index(index)
		return (2*(index+1))-1
	end

	def heap_right_node_index(index)
		return 2*(index+1)
	end
end

max_value = 10000
sizes = [100,1000,10000,100000]

puts "Sorting with heapsort"
sizes.each do |size|
	array = []
	size.times { |n| array << rand(max_value) }
	start = Time.now
	array.heapsort!
	time = Time.now - start
	puts "Sorted size #{size} in #{time} seconds"
end

puts "Programming language:\tRuby #{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}"
puts "Operating system:\t#{`uname -srm`}"
