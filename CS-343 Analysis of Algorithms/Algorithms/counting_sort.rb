#!/usr/bin/env ruby

class Array
	def counting_sort
		b = Array.new(self.max,0)
		c = Array.new(self.size,0)
		self.each do |int|
			b[int] = 0 if b[int] == nil
			b[int] += 1
		end
		total = 0
		(0..b.size).to_a.each do |i|
			old_value = b[i]
			b[i] = total
			total += (old_value || 0)
		end
		self.each do |int|
			c[b[int]] = int
			b[int] += 1
		end
		return c
	end
end

max_value = 10000
sizes = [100,1000,10000,100000,1000000,10000000,100000000]

puts "Sorting with counting sort"
sizes.each do |size|
	array = []
	max_value.times { |n| array << rand(size) }
	start = Time.now
	array.counting_sort
	time = Time.now - start
	puts "Sorted size #{size} in #{time} seconds"
end

puts "Programming language:\tRuby #{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}"
puts "Operating system:\t#{`uname -srm`}"
