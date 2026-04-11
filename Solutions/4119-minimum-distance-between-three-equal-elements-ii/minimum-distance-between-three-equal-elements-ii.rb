# @param {Integer[]} nums
# @return {Integer}
def minimum_distance(nums)
  # Step 1: Store indices for each value
  # Example: {1 => [0,2,3], 2 => [1,4], ...}
  index_map = Hash.new { |h, k| h[k] = [] }
  
  nums.each_with_index do |num, i|
    index_map[num] << i
  end

  # Step 2: Initialize result as a large number
  min_dist = Float::INFINITY

  # Step 3: Process each value's indices
  index_map.each do |value, indices|
    # Skip if fewer than 3 occurrences (can't form a tuple)
    next if indices.length < 3

    # Step 4: Try all consecutive triples
    # Since indices are naturally sorted (we added in order)
    (0..indices.length - 3).each do |i|
      left  = indices[i]       # i
      mid   = indices[i + 1]   # j
      right = indices[i + 2]   # k

      # Distance simplifies to 2 * (k - i)
      dist = 2 * (right - left)

      # Update minimum distance
      min_dist = [min_dist, dist].min
    end
  end

  # Step 5: If no valid tuple found, return -1
  return -1 if min_dist == Float::INFINITY

  min_dist
end