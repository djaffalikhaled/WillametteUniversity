#!/usr/bin/env ruby

sizes = [10,15,20,100]

def rand_string(size)
	return (0...size).map { (65 + rand(26)).chr }.join
end

def lcs_bruteforce(sequence1, sequence2)
	largest = 0
	search_scope = 0
	sequence1_position = 0
	sequence2_position = 0
	for i in 0..sequence1.length-1
		for j in 0..sequence2.length-1
			sequence2_position = j
			sequence1_position = i
			search_scope = 0
			while (sequence1_position < sequence1.length) && (sequence2_position < sequence2.length)
				if sequence1[sequence1_position] == sequence2[sequence2_position]
					search_scope += 1
					sequence2_position += 1
					largest = search_scope if search_scope > largest
				else
					sequence2_position = j
				end
				sequence1_position += 1
			end
		end
	end
	return largest
end

sizes.each do |size|
	starttime = Time.now
	sequence1 = rand_string(size)
	sequence2 = rand_string(size)
	size = lcs_bruteforce(sequence1, sequence2)
	stoptime = Time.now - starttime
	puts "Completed #{size} LCS brute force in #{stoptime} seconds (found #{size})"
end
