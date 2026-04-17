# @param {Integer[]} nums
# @return {Integer}
def min_mirror_pair_distance(nums)
  
  # This hash will store:
  # key   -> reversed value of a number we have seen
  # value -> the index where it appeared
  #
  # Example:
  # if nums[i] = 120, reversed = 21
  # we store: { 21 => i }
  #
  last_seen = {}
  
  # Start with a very large number (infinity)
  # We will try to minimize this value
  min_distance = Float::INFINITY
  
  # Loop through the array with index
  nums.each_with_index do |num, i|
    
    # Step 1: Check if current number already exists
    # in our hash (meaning: some previous number reversed to this)
    #
    # If yes:
    # that means we found a mirror pair
    #
    if last_seen.key?(num)
      # Calculate distance between indices
      distance = i - last_seen[num]
      
      # Update minimum distance if smaller
      min_distance = [min_distance, distance].min
    end
    
    # Step 2: Reverse the current number
    #
    # Convert to string -> reverse string -> convert back to integer
    #
    # Example:
    # 120 -> "120" -> "021" -> 21
    #
    reversed = num.to_s.reverse.to_i
    
    # Step 3: Store the reversed value in the hash
    #
    # Why?
    # So that if we later encounter this reversed number,
    # we can quickly detect a mirror pair.
    #
    last_seen[reversed] = i
  end
  
  # Step 4: If we never found any mirror pair,
  # min_distance will still be infinity
  #
  # In that case, return -1
  #
  return -1 if min_distance == Float::INFINITY
  
  # Otherwise return the smallest distance found
  min_distance
end