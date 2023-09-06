HEX = {0=>"0", 1=>"1", 2=>"2", 3=>"3", 4=>"4", 5=>"5", 6=>"6", 7=>"7", 
8=>"8", 9=>"9", 10=>"a", 11=>"b", 12=>"c", 13=>"d", 14=>"e", 15=>"f"}

# Note that questions states 32-Hexadecimal characters which is 0-9 a-f

def each_section_hex(n)
  uuid_hex = ''
  n.times {
    a = rand(0..15)
    uuid_hex << HEX[a]
  }
  uuid_hex
end

def gen_uuid()
uuid_value = ""
n = [8,4,4,4,12]
counter = 0

5.times {
  uuid_value << each_section_hex(n[counter])
  uuid_value << "-" unless counter == 4
  counter += 1
  }
  
p uuid_value
end

gen_uuid()

# alternate solution

# def uuid_parts(t)
#   char_array = ('0'..'9').to_a + ('a'..'z').to_a
#   part_str = ""
#   t.times do
#     part_str << char_array.sample
#   end
#   part_str
# end


# def uuid_generator()
#   uuid = ""

#   uuid << uuid_parts(8)
#   uuid << "-" <<  uuid_parts(4)
#   uuid << "-" <<  uuid_parts(4)
#   uuid << "-" <<  uuid_parts(4)
#   uuid << "-" <<  uuid_parts(12)
#   uuid
# end

p uuid_generator()
