#!/usr/bin/env ruby

def add(firstbinary, secondbinary)
	answer = ""
	carry = 0
	i = 0
	firstbinary.reverse!.split("").each do |firstbit|
		secondbit = secondbinary.reverse!.split("")[i]
		value = firstbit.to_i + secondbit.to_i + carry
		secondbinary.reverse!.split("")[6]
		if value == 3
			answer.insert(0, "1")
			carry = 1
		elsif value == 2
			answer.insert(0, "0")
			carry = 1
		elsif value ==1
			answer.insert(0, "1")
			carry = 0
		elsif value == 0
			answer.insert(0, "0")
			carry = 0
		end
		i = i + 1
#		puts "We are adding bits #{firstbit} and #{secondbit}.  Carry is #{carry}.  Added: #{value}.\nAnswer at this point: #{answer}"
	end
	firstbinary.reverse!.split("")[0]
#	puts "Overflow check: first of firstbin: #{firstbinary.split("")[0]}.  First of secondbin: #{secondbinary.split("")[0]}.  First of answer: #{answer.split("")[0]}."
	if answer.size > @@bitsize
		puts "There was an overflow, exiting."
		exit(0)
	end
	if firstbinary.reverse!.split("")[0] == "0" && secondbinary.split("")[0] == "0" && answer.split("")[0] == "1"
		puts "There was an overflow, exiting."
		exit(0)
	end
	if firstbinary.reverse!.split("")[0] == "1" && secondbinary.split("")[0] == "1" && answer.split("")[0] == "0"
		puts "There was an overflow, exiting."
		exit(0)
	end
	return answer
end

def intToBin(num)
	binary = num.abs.to_s(2)
	if binary.size > @@bitsize - 1
		puts "The integer does not fit in the register."
		exit(0)
	end
	until binary.size == @@bitsize
		binary.insert(0, "0")
	end
	return binary
end

def convert(num)
	if num >= 0
		return intToBin(num)
	elsif num < 0
		if num.abs <= (2**@@bitsize)/2
			return ((2**@@bitsize)-num.abs).to_s(2)
		else
			puts "The integer does not fit in the register."
			exit(0)
		end
	end
end

def main
	puts "Hayden Parker - Lab 2"
	print "Please enter the size of the registers in bits\n>"
	@@bitsize = gets.to_i
	print "Please enter the first number to add:\n>"
	firstnum = gets.to_i
	print "Please enter the first number to add:\n>"
	secondnum = gets.to_i
	puts "First number in binary:"
	firstbinary = convert(firstnum)
	puts firstbinary
	puts "Second number in binary:"
	secondbinary = convert(secondnum)
	puts secondbinary
	answer = add(firstbinary, secondbinary)
	puts "The answer in binary is:"
	puts answer
	puts "The base 10 version is:"
	if answer.split("")[0].to_i == 1
		answer = (answer.to_i(2))-(2**@@bitsize)
	elsif answer.split("")[0].to_i == 0
		answer = answer.to_i(2)
	end
	puts answer
	if firstnum + secondnum == answer
		puts "Self test passed."
	else
		puts "Self test failed."
	end
end

main()
