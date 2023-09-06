# Create a hash that expresses the frequency with which each letter occurs in this string:

statement = "The Flintstones Rock"

result = {}
statement.chars.each do |char|
  letter_length = statement.count(char)
  result[char] = letter_length
end

p result



