hsh = {first: ['the', 'quick'], second: ['brown', 'fox'], third: ['jumped'], 
fourth: ['over', 'the', 'lazy', 'dog']

}

hsh.each {|key, value|
  value.each {|word|
    word.chars.each {|alphabet|
      p alphabet if "aeiou".include?(alphabet)
    }
  }
}


hsh.each do |_, value|
  value.each do |str|
    str.chars.each do |char|
      # puts str
      puts char if char =~ /[aeiouAEIOU]/
    end
  end
end