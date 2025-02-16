=begin

Given a string, produce a new string with every other word removed

input: string
output: new string

rules:
    Explicit rules
    - Remove the alternate words from a string
    - We will start with keeping the first word and then deleting the second word and so on..
    Implicit rules
    - Strings with only 1 word should return string as is
    - Words are identified as space characters on either side of them
    
    Example:
    string = "A man is walking on the street"
            ["A","man","is","walking", "on", "the", "street"]
              0    1     2      3       4      5       6
    remove_altr_word(string)
Algorithm:
    Create an array of words from the string
    Select the words from the array at even index and store these words in a new
    array
    Return the array with deleted words
    Join the array back to string with space character inbetween every word
    The new string is the output

=end

def remove_altr_word(str_arr)
    
    alt_word = str_arr.select.with_index do |word, index|
        word if index % 2 == 0
    end
    alt_word
end

str = "A man is walking on the street"

# p str.split

new_arr = remove_altr_word(str.split)

p new_arr.join(" ")















