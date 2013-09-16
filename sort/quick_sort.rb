# coding: utf-8
def quick_sort( seq )
  if seq.length <= 1 then return seq end
  pivot = seq[0]; left = []; right = []
  for n in 1..seq.length-1
    if seq[n] < pivot
      left << seq[n]
    else
      right << seq[n]
    end
  end
  return quick_sort(left) + [pivot] + quick_sort(right)
end

if __FILE__ == $0
  raise "assert" unless [1,2,3] == quick_sort( [1,2,3] )
  raise "assert" unless [1,2,3] == quick_sort( [3,2,1] )
  raise "assert" unless [1,2,3] == quick_sort( [3,1,2] )
end
