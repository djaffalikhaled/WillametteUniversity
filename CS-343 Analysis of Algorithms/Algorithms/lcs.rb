#!/usr/bin/env ruby

sizes = [10,15,20,100,1000,10000]

def rand_string(size)
	return (0...size).map { (65 + rand(26)).chr }.join
end

def lcs_length(sequence1, sequence2)
	s1_length = sequence1.size
	s2_length = sequence2.size
	b = Array.new(0,s1_length)
	s1_length.times do |i|
		b[i] = Array.new(s2_length, 0)
	end
	c = Array.new(s1_length, 0)
	s1_length.times do |i|
		c[i] = Array.new(s2_length, 0)
	end
	s1_length.times do |i|
		s2_length.times do |j|
			if sequence1[i] == sequence2[j]
				c[i][j] = c[i-1][j-1] + 1
				b[i][j] = :upleft
			elsif c[i-1][j] >= c[i][j-1]
				c[i][j] = c[i-1][j]
				b[i][j] = :up
			else
				c[i][j] = c[i][j-1]
				b[i][j] = :left
			end
		end
	end
	return b, c
end

def print_lcs(b, sequence1, i, j)
	return if i == 0 || j == 0
	if b[i][j] == :upleft
		print_lcs(b, sequence1, i-1, j-1)
		print sequence1[i]
	elsif b[i][j] == :up
		print_lcs(b, sequence1, i-1, j)
	else
		print_lcs(b, sequence1, i, j-1)
	end
end

sizes.each do |size|
	start = Time.now
	sequence1 = rand_string(size)
	sequence2 = rand_string(size)
	b, c = lcs_length(sequence1, sequence2)
	time_elapsed = Time.now - start
	puts "Completed size #{size} in #{time_elapsed} seconds, printing:"
	print_lcs(b, sequence1, sequence1.size-1, sequence2.size-1)
	puts
end
