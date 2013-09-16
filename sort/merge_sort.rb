def pop_smallest( left_right )
  index = 0
  result = -1
  if left_right[0][0] < left_right[1][0]
    index = 0
  else
    index = 1
  end
  result = left_right[index][0]
  left_right[index].delete_at(0)
  return result
end  

def sort_connect( left_right )
  result = []
  while true
    if    left_right[0].length == 0 then result = result + left_right[1];break
    elsif left_right[1].length == 0 then result = result + left_right[0];break
    else result << pop_smallest( left_right )
    end
  end
  return result
end

def merge_sort( seq )
  len = seq.length
  if len <= 1 then return seq end
  p seq
  p len
  left_right = [ merge_sort( seq[0..(len/2)-1]),
                 merge_sort( seq[len/2..len-1 ])
               ]
  return sort_connect( left_right )
end

if __FILE__ == $0
  left_right = [[1,3],[2,4]]
  result = pop_smallest( left_right )
  raise "assert" unless result == 1 and left_right == [[3],[2,4]]
  result = pop_smallest( left_right )
  raise "assert" unless result == 2 and left_right == [[3],[4]]
  left_right = [[1,3],[2,4]]
  raise "assert" unless [1,2,3,4] == sort_connect( left_right )
  raise "assert" unless [1,2,3] == merge_sort( [1,2,3] )  
  raise "assert" unless [1,2,3] == merge_sort( [3,2,1] )
end
