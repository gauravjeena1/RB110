original = [{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}]
arr = []
arr = original.map {|hash|
  new_hash = {}
  hash.each {|key, value|
    new_hash[key] = value + 1
  }
  new_hash
}

p original
p arr

# alternate solution
[{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}].map do |hsh|
  hsh.keys.each do |key|
    hsh[key] += 1
  end
  hsh
end