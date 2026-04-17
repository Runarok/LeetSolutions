# @param {Integer[]} nums
# @param {Integer} k
# @return {Integer}
def subarray_sum(nums, k)
  # HashMap to store frequency of prefix sums
  # key = prefix sum, value = count of occurrences
  prefix_count = Hash.new(0)
  
  # Important: prefix sum 0 occurs once (empty prefix)
  prefix_count[0] = 1
  
  current_sum = 0
  count = 0

  nums.each do |num|
    # Add current number to running sum
    current_sum += num

    # Check if there exists a prefix sum such that:
    # current_sum - previous_sum = k
    # => previous_sum = current_sum - k
    if prefix_count.has_key?(current_sum - k)
      count += prefix_count[current_sum - k]
    end

    # Store current prefix sum
    prefix_count[current_sum] += 1
  end

  return count
end