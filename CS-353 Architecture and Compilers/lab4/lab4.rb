#!/usr/bin/env ruby

##
##	Hayden Parker - Lab 4
##

class String
	def colorize(color_code)
		"\e[#{color_code}m#{self}\e[0m"
	end

	def red
		colorize(31)
	end

	def green
		colorize(32)
	end
end

class Gate
	@in1 = nil
	@in2 = nil
	@state = nil
	def initialize(input1, input2)
		@in1 = input1
		@in2 = input2
	end
end

class AND < Gate
	def bool
		@in1.bool && @in2.bool
	end
end

class OR < Gate
	def bool
		@in1.bool || @in2.bool
	end
end

class NAND < Gate
	def bool
		if @in1.bool && @in2.bool == true
			return false
		else
			return true
		end
	end
end

class NOR < Gate
	def bool
		if @in1.bool && @in2.bool == false
			return true
		else
			return false
		end
	end
end

class XOR < Gate
	def bool
		if @in1.bool == @in2.bool
			return false
		else
			return true
		end
	end
end

class XNOR < Gate
	def bool
		@in1.bool == @in2.bool
	end
end

class NOT
	def initialize(input)
		@input = input
	end
	
	def bool
		if @input.bool == true
			return false
		elsif @input.bool == false
			return true
		end
	end
end

class Switch
	def initialize
		@on = false
	end

	def state
		if @on == true
			"[ON]  ".green
		elsif @on == false
			"[OFF] ".red
		end
	end
	
	def bool
		return @on
	end
	
	def flip
		if @on == false
			@on = true
		elsif @on == true
			@on = false
		end
	end
end

class Light
	def initialize(target)
		@on = false
		@target = target
	end

	def state
		@on = @target.bool if @target != nil
		if @on == true
			"[ON]  ".green
		elsif @on == false
			"[OFF] ".red
		end
	end

	def setTarget(target)
		@target = target
	end
end

class ON
	def bool
		true
	end
end

def printout(filename, s1, s2, s3, s4, l1, l2, l3, l4)
	system "clear"
	puts "Hayden Parker - Lab 4 (loaded file: #{filename})"
	puts "\nSwitches:"
	puts s1.state + s2.state + s3.state + s4.state
	puts "\nOutput:"
	puts l1.state + l2.state + l3.state + l4.state
end

puts "Hayden Parker - Lab 4"
if ARGV.size == 0
	puts "Warning: ".red + "No file provided.  Please provide a filename as an argument."
	exit(0)
else
	filename = ARGV[0]
end
print "Checking for file..."
if not File.exist?(filename)
	puts "\nWarning: ".red + "The file \"#{filename}\" does not appear to exist."
	exit(0)
end
puts "\t\tok".green
print "Building switches and lights..."
s1 = Switch.new
s2 = Switch.new
s3 = Switch.new
s4 = Switch.new
l1 = Light.new(nil)
l2 = Light.new(nil)
l3 = Light.new(nil)
l4 = Light.new(nil)
puts "\tok".green
print "Parsing file contents..."

File.open(filename).read.each_line do |line|
	line = line.split(" ")
	if line.size > 4
		puts "Warning: ".red + "One of the lines in your circuit has more then 4 items."
		exit(0)
	end
	if (line.size == 4) && (line[2].upcase == "ON" || line[3].upcase == "ON")
		if line[2].upcase == "ON"	
			eval("@#{line[1].downcase} = #{line[0].upcase}.new(ON.new, #{line[3].downcase})")
		elsif line[3].upcase == "ON"
			eval("@#{line[1].downcase} = #{line[0].upcase}.new(#{line[2].downcase}, ON.new)")
		end
	elsif line[0].upcase == "LIGHT"
		eval("#{line[1].downcase}.setTarget(@#{line[2].downcase})")
	elsif line.size == 4 && line[1].split("")[0] != "l"
		if line[2].downcase.split("")[0] == "a"
			line[2].insert(0, "@")
		end		
		if line[3].downcase.split("")[0] == "a"
			line[3].insert(0, "@")
		end
		eval("@#{line[1].downcase} = #{line[0].upcase}.new(#{line[2].downcase}, #{line[3].downcase})")
	elsif line.size == 4 && line[1].split("")[0] == "l"
		if line[2].downcase.split("")[0] == "a"
			line[2].insert(0, "@")
		end		
		if line[3].downcase.split("")[0] == "a"
			line[3].insert(0, "@")
		end
		eval("#{line[1].downcase}.setTarget(#{line[0].upcase}.new(#{line[2].downcase}, #{line[3].downcase}))")
	elsif line.size == 3 && line[0].upcase == "NOT"
	
		if line[2].downcase.split("")[0] == "a"
			line[2].insert(0, "@")
		end	
		
		eval("@#{line[1].downcase} = #{line[0].upcase}.new(#{line[2].downcase})")
	end
end
puts "\tok".green
puts "The file \"#{filename}\" has been parsed successfully.\nPress enter to begin interaction with the circuit."
STDIN.gets
loop {
	printout(filename, s1, s2, s3, s4, l1, l2, l3, l4)
	puts "\nWhich switch would you like to flip? (1-4).  Enter 5 to exit."
	choice = "0"
	until ["1","2","3","4", "5"].include? choice
		print ">"
		choice = STDIN.gets.chomp
	end
	case choice.to_i
	when 1
		s1.flip
	when 2
		s2.flip
	when 3
		s3.flip
	when 4
		s4.flip
	when 5
		exit(0)
	end
}
