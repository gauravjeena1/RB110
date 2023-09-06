arr = [['b', 'c', 'a'], [2, 1, 3], ['blue', 'black', 'green']]

p arr.map {|element_arr|
  element_arr.sort {|a, b| b <=> a}
}