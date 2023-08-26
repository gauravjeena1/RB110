ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

# Pick out the minimum age from our current Munster family hash:

# longer implementation using `#each`
min_age = ages.values[0]
ages.values.each do |age|
  min_age = age if age < min_age
end

p min_age

p ages.values.min # this returns just the age which is what is asked in the question

p ages.min # this returns name and age as key-value pair