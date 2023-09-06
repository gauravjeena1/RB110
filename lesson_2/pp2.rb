books = [
  {title: 'One Hundred Years of Solitude', author: 'Gabriel Garcia Marquez', published: '1967'},
  {title: 'The Great Gatsby', author: 'F. Scott Fitzgerald', published: '1925'},
  {title: 'War and Peace', author: 'Leo Tolstoy', published: '1869'},
  {title: 'Ulysses', author: 'James Joyce', published: '1922'}
]

# p books.map {|hash|
#   hash.sort_by { |key, value|
#     hash[:published].to_i
#   }
# }


books.sort_by! do |book|
  book[:published]
end

p books