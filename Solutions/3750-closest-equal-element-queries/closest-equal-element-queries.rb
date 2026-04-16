# @param {Integer[]} nums
# @param {Integer[]} queries
# @return {Integer[]}
def solve_queries(nums, queries)
  n = nums.length
  
  # Step 1: Map each value to all its indices
  # Example: {1 => [0,2,4], 3 => [1,5]}
  positions = Hash.new { |h, k| h[k] = [] }
  
  nums.each_with_index do |val, idx|
    positions[val] << idx
  end
  
  # Step 2: Prepare result array
  # For each index, we store the minimum distance to same value
  result = Array.new(n, -1)
  
  # Step 3: Process each group of same values
  positions.each do |val, indices|
    
    # If only one occurrence → always -1
    if indices.length == 1
      result[indices[0]] = -1
      next
    end
    
    # Sort indices (important for distance calculation)
    indices.sort!
    
    m = indices.length
    
    # Step 4: For each index in this group
    indices.each_with_index do |idx, i|
      
      # Get previous index in circular manner
      prev = indices[(i - 1) % m]
      
      # Get next index in circular manner
      nxt = indices[(i + 1) % m]
      
      # Compute circular distance to prev
      dist_prev = (idx - prev).abs
      dist_prev = [dist_prev, n - dist_prev].min
      
      # Compute circular distance to next
      dist_next = (idx - nxt).abs
      dist_next = [dist_next, n - dist_next].min
      
      # Store the minimum of both
      result[idx] = [dist_prev, dist_next].min
    end
  end
  
  # Step 5: Answer queries
  # Just lookup precomputed results
  queries.map { |q| result[q] }
end