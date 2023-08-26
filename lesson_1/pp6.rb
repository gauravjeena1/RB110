flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

# Write code that changes the array below so that all of the names are shortened to just the first three characters. 
# Do not create a new array.

flintstones.each_with_index do |name, idx|
  name = name.chars.first(3).join
  flintstones[idx] = name
end

p flintstones # not idiomatic solution, use `map!`