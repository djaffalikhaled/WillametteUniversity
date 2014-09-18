#!/usr/bin/env ruby

#####################
## Hayden Parker   ##
## Lab 6		   ##
## PC231 Simulator ##
## 3/19/13         ##
#####################

## Inputed hex codes must be deliminated by a space
## Hex codes from file must be deliminated by new lines

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

class Register
	def initialize
		@value = 0
	end
	def sub(value)	# (SUB R5,R6) == (R6 = R6 - R5) == (r6.sub(r5))
		@value = @value.ord - value.ord
	end
	def add(register)
		@value = @value + register.value.to_i(16)
	end
	def value
		@value
	end
	def inc(n)
		@value += n
	end
	def zero
		@value = 0
	end
	def set(bits)
		@value = bits
	end
	def shift(count)
		@value >> count
	end
	def and(register)	# (AND R5,R6) == (R6 = R5 & R6) == (r6.and(r5))
		@value = @value & register.value
	end
	def copy(register)	# (COPY R5,R6) == (R6 = R5) == (r6.copy(r5))
		@value = register.value
	end
	def load(address, hexarray)
		@value = hexarray[address.to_i]
	end
	def store(address, hexarray)
	#	puts "WRITING #{@value} TO ADDRESS #{address} IN RAM.  CURRENT VALUE: #{hexarray[address.to_i]}"
		hexarray[address.to_i] = @value
	end
	def read(dev)
		@value = dev.read
	end
	def write(dev)
		dev.write(@value)
	end
	
end

class AD
	def write(n)
		puts "ASCII Output: #{n.chr}"
	end
	
	def read
		puts "Enter an ASCII character:"
		return STDIN.gets.chomp[0]
	end
end

class DD
	def write(n)
		puts "Decimal Output: #{n.to_i}"
	end
	
	def read
		puts "Enter a decimal value:"
		return STDIN.gets.to_i
	end	
end

class HD
	def write(n)
		puts "Hex Output: #{n.to_s(16)}"
	end
	
	def read
		puts "Enter a hex character:"
		return STDIN.gets.to_i(16)
	end
end

file = false
if ARGV[0] == nil
	ARGV[0] = "*****"
end
puts "PC231 Simulator starting..."
print "Checking ARGV for filename..."
if File.exists?(ARGV[0])
	puts "\tok".green
	file = true
	print "Parsing file..."
	hexarray = File.open(ARGV[0]).readlines
	puts "\t\t\tok".green
else
	puts "\n[-]".red + " file not found - using stdin"
end
print "Building virtual machine..."
r0 = Register.new
r1 = Register.new
r2 = Register.new
r3 = Register.new
r4 = Register.new
r5 = Register.new
r6 = Register.new
r7 = Register.new
r8 = Register.new
r9 = Register.new
j0 = Register.new
j1 = Register.new
j2 = Register.new
j3 = Register.new
dr = Register.new
pc = Register.new
ad = AD.new
dd = DD.new
hd = HD.new
registers = [r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,j0,j1,j2,j3,dr,pc]
jumps = [j0,j1,j2,j3]
devices = [dd,hd,ad]
puts "\tok".green
if file == false
	puts "Please paste your hex codes here, then press enter:"
	hexarray = STDIN.gets.split(" ")
end
i = 0
hexarray.each do |opcode|
	hexarray[i] = opcode.chomp
	i += 1
end
print "Press enter to begin execution..."
STDIN.gets
halt = false
while halt != true
	case hexarray[pc.value][0].to_i(16)
		when 0
			halt = true
		when 1
			register = hexarray[pc.value][1..-1]
			registers[register.to_i(16)].zero
			pc.inc(1)
		when 2
			register = registers[hexarray[pc.value][1].to_i(16)]
			value = hexarray[pc.value][2].to_i(16)
			register.set(value)
			pc.inc(1)
		when 3
			value = hexarray[pc.value][1..-1]
			dr.set(value.to_i(16))
			pc.inc(1)
		when 4
			value = hexarray[pc.value][2].to_i(16)
			if value < 8
				value += 1
			elsif value >= 8
				value = 7-value
			end
			registers[hexarray[pc.value][1].to_i(16)].inc(value)
			pc.inc(1)
		when 5
			registers[hexarray[pc.value][1].to_i(16)].shift(hexarray[pc.value][2].to_i(16))
			pc.inc(1)
		when 6
			registers[hexarray[pc.value][2].to_i(16)].add(reisters[hexarray[pc.value][1].to_i(16)])
			pc.inc(1)
		when 7
	#		puts "doing subtraction.  #{registers[hexarray[pc.value][2].to_i(16)].value} - #{registers[hexarray[pc.value][1].to_i(16)].value.ord}"
			registers[hexarray[pc.value][2].to_i(16)].sub(registers[hexarray[pc.value][1].to_i(16)].value)
			pc.inc(1)
		when 8
			registers[hexarray[pc.value][2].to_i].and(registers[hexarray[pc.value][1].to_i])
			pc.inc(1)
		when 9
			registers[hexarray[pc.value][2].to_i(16)].copy(registers[hexarray[pc.value][1].to_i(16)])
			pc.inc(1)
		when 10
			registers[hexarray[pc.value][1].to_i(16)].load(registers[(hexarray[pc.value][2].to_i(16))].value,hexarray)
			pc.inc(1)
		when 11
			registers[hexarray[pc.value][1].to_i(16)].store(registers[(hexarray[pc.value][2].to_i(16))].value,hexarray)
			pc.inc(1)
		when 12
			device = hexarray[pc.value][2].to_i(16)
			if device == 0
				registers[hexarray[pc.value][1].to_i(16)].read(dd)
			elsif device == 1
				registers[hexarray[pc.value][1].to_i(16)].read(hd)
			elsif device == 2
				registers[hexarray[pc.value][1].to_i(16)].read(ad)
			end
			pc.inc(1)
		when 13
			device = hexarray[pc.value][2].to_i
			if device == 0
				registers[hexarray[pc.value][1].to_i(16)].write(dd)
			elsif device == 1
				registers[hexarray[pc.value][1].to_i(16)].write(hd)
			elsif device == 2
				registers[hexarray[pc.value][1].to_i(16)].write(ad)
			end
			pc.inc(1)
		when 14
			statement = hexarray[pc.value][1..-1]
			register = registers[statement[0].to_i(16)]
			parse = statement[1].to_i(16).to_s(2)
			until parse.size == 4
				parse = "0" + parse
			end
			condition = parse[0..1].to_i(2)
			jregister = parse[2..3].to_i(2)
			jreg = jumps[jregister]
			if condition == 0
				if register.value < 0
					pc.set(jreg.value)
				else
					pc.inc(1)
				end
			elsif condition == 1
				if register.value > 0
					pc.set(jreg.value)
				else
					pc.inc(1)
				end
			elsif condition == 2
	#			puts "was what we just entered a period?  register.value = #{register.value}"
				if register.value == 0
					pc.set(jreg.value)
				else
					pc.inc(1)
				end
			elsif condition == 3
				if register.value != 0
					pc.set(jreg.value)
				else
					pc.inc(1)
				end
			end
		when 15
			jump = hexarray[pc.value][1..-1].to_i(16)
			pc.set(jump)
	end
end

#puts "####beginning hexarray dump######".red
#puts hexarray
#puts "#####ending hexarray dump########".green
