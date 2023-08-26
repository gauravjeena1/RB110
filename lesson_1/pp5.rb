flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
# Find the index of the first name that starts with "Be"

index = (flintstones.each_with_index do |name, idx|
  break idx if name.start_with?("Be")
end)

p index