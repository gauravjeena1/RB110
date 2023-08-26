# Given the array below

flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]
# Turn this array into a hash where the names are the keys and the values 
# are the positions in the array.

# flintstones = flintstones.map.with_index { |name, index|
# [name,index]
# }

# flintstones =  flintstones.to_h

# p flintstones

# flintstones = flintstones.each_with_index { |name, index|
# [name,index]
# }

# p flintstones

# flintstones =  flintstones.to_h

# p flintstones

# Solution using loop method
# counter = 0

# loop do
#   flintstones_hash[flintstones[counter]] = counter
#   counter += 1
#   break if counter >= flintstones.size
# end