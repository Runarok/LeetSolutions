# @param {Integer[]} nums
# @param {Integer} target
# @return {Integer[]}
def two_sum(nums, target)
  # Create a hash to store the numbers we've seen and their indices
  seen = {}

  # Iterate through the array with index
  nums.each_with_index do |num, i|
    # Calculate the complement (the number we need to add to 'num' to make 'target')
    complement = target - num

    # Check if the complement is already in the hash map
    if seen.key?(complement)
      # If found, return the indices of the complement and the current number
      return [seen[complement], i]
    end

    # Otherwise, store the current number and its index in the hash map
    seen[num] = i
  end
end
