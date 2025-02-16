=begin

Problem:
We have rows grouped with integers. Starting with the integer 2. The number of
integers in each row is corresponding to the number of the particular row. For example.
Row number 3 has 3 integers
Row number 7 has 7 integers

Problem states that if you are given a row number then you need to calculate the
sum of all the integers in that row.

Input: integer
Output: integer

1     0   2
2     1   4 6
3     2   8 10 12
4     3   14 16 18 20
  and so on
  
  We will continue
  
  Algorithm
  1. Create a nested array upto the the row that is given as input
    How to create the array
    - start with 2 as first number
    - start a loop that
    
    
  2. The index represents the row number in the array structure so first row is index 0
  3. Then using array #sum method sum all the elements in the index/row number
  



=end


def create_array(row_num)
  
  num = 2
  count = 1
  out_arr = []

    row_num.times do
      in_arr = []
      
      count.times do   #create inner row
        in_arr << num
        num += 2
      end
      out_arr << in_arr    #append inner_array to outer_array
      count +=1
    end

  out_arr
end

def create_sum(arr, row_num)
  
  arr[row_num-1].sum
  
end

puts "Input the row number"
row_num = gets.chomp.to_i

arr = create_array(row_num)
p arr

p create_sum(arr,row_num)



