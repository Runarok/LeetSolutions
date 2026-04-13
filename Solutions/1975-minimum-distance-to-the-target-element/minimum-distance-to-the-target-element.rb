# @param {Integer[]} nums   -> array of integers
# @param {Integer} target   -> value we are searching for
# @param {Integer} start    -> starting index
# @return {Integer}         -> minimum absolute distance

def get_min_distance(nums, target, start)
  # Initialize minimum distance with a large number
  # (since max length is 1000, this is safe)
  min_distance = Float::INFINITY

  # Iterate through the array with index
  nums.each_with_index do |num, i|
    
    # Check if current element matches target
    if num == target
      
      # Calculate absolute distance from start index
      distance = (i - start).abs
      
      # Update minimum distance if smaller distance is found
      min_distance = [min_distance, distance].min
    end
  end

  # Return the smallest distance found
  min_distance
end