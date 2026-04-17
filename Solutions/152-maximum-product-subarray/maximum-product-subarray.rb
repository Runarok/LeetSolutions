# @param {Integer[]} nums
# @return {Integer}
def max_product(nums)
  # Initialize result, max and min with the first element
  max_so_far = nums[0]
  min_so_far = nums[0]
  result = nums[0]

  # Loop through the array starting from index 1
  (1...nums.length).each do |i|
    current = nums[i]

    # If current number is negative, swap max and min
    # Because multiplying by negative flips sign
    if current < 0
      max_so_far, min_so_far = min_so_far, max_so_far
    end

    # Update max product ending here:
    # either take current number alone OR extend previous subarray
    max_so_far = [current, max_so_far * current].max

    # Update min product ending here:
    # needed for future negative flips
    min_so_far = [current, min_so_far * current].min

    # Update global result
    result = [result, max_so_far].max
  end

  return result
end