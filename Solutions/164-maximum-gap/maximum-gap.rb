def maximum_gap(a)
  # Sort the array in ascending order
  a.sort!

  # Iterate over consecutive pairs and track the maximum gap
  a.each_cons(2).reduce(0) do |max_gap, pair|
    # Compute gap between adjacent elements
    gap = pair.last - pair.first

    # Keep the maximum gap found so far
    [max_gap, gap].max
  end
end
