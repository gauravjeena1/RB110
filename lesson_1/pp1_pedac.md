PROBLEM:

Given a string, write a method `palindrome_substrings` which returns
all the substrings from a given string which are palindromes. Consider
palindrome words case sensitive.

Test cases:

palindrome_substrings("supercalifragilisticexpialidocious") == ["ili"]
palindrome_substrings("abcddcbA") == ["bcddcb", "cddc", "dd"]
palindrome_substrings("palindrome") == []
palindrome_substrings("") == []

input: string
output: array of strings

rules: 
      Explicit requirements:
          - every palindrome substring is a string that read the same forwards
          backwards
          - palindromes are case sensitive so e.g. 'ada' is a palindrome and 'Ada' is not
          
      Implicit requirements:
          - Return value should be an array
          - Should return an empty array when an empty string is given as input
          - there can be smaller palindrome substrings within a larger palindrome substring
          - palindrome substrings are atleast 2 characters long

Data structure: Array

Algorithm:
    - Intialize a variable to an empty array, this will store our output - result_arr
    - Find all the possible substrings from the given string and store in another
    array, lets call it all_substrings
    - Then we will iterate through this array that is all_substrings and find out
    which ones are palindrome
    - If we find a palindrome string then we will append it to the empty array that
    intialized earlier called result_arr
    - return the result_arr