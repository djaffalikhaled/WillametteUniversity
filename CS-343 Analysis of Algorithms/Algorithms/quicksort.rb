#!/usr/bin/env ruby

# Hayden Parker
# Febuary 16th, 2014
# CS-343 Analysis of Algorithms

class Array
	def quicksort!(left=0,right=(self.size-1))
		if left < right
			new_pivot = partition(left, right)
			quicksort!(left, new_pivot-1)
			quicksort!(new_pivot+1, right)
        end
	end
	
	def quicksort
		tmp = self
		tmp.quicksort!
		return tmp
	end
	
	private
	
	def partition(left,right)
		i = left
		j = right
		pivot_value = self[left]
		while j > i
			while (self[i] <= pivot_value) && (j > i)
				i += 1
			end
			while (self[j] > pivot_value) && (j >= i)
				j -= 1
			end
			if j > i
				swap!(i,j)
			end
		end
		swap!(left,j)
		return j
	end
	
	def swap!(a,b)
		self[a], self[b] = self[b], self[a]
		self
	end
	
end

max_value = 10000
sizes = [100,1000,10000,100000]

puts "Sorting with quicksort"
sizes.each do |size|
	array = []
	size.times { |n| array << rand(max_value) }
	start = Time.now
	array.quicksort!
	time = Time.now - start
	puts "Sorted size #{size} in #{time} seconds"
end

puts "Programming language:\tRuby #{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}"
puts "Operating system:\t#{`uname -srm`}"
