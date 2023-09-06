arr = ['10', '11', '9', '7', '8']

arr.sort! {|element1, element2|
  element2.to_i <=> element1.to_i
}

# arr.map! {|element1|
#   if element1.to_i < element2.to_i
#     element1
#   else
#     element2
#   end
# }

# arr.sort_by! {|element1, element2| element1.to_i < element2.to_i}

p arr

arr = ['10', '11', '9', '7', '8']

p(arr.sort_by do |num|
  -num.to_i         # this negates the integer and since -7 is greater than -8 in negative numbers so it sorts in descending order
end)