arr = [[2], [3, 5, 7, 12], [9], [11, 13, 15]]

p arr.map {|arr_num|
  arr_num.select {|num|
    num % 3 == 0
  }
}

p arr.map {|arr_num|
  arr_num.reject {|num|
    num % 3 != 0
  }
}
