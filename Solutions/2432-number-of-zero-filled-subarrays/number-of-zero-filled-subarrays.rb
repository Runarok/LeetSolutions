# @param {Integer[]} nums
# @return {Integer}
def zero_filled_subarray(nums)
  count = 0   # This will hold the total number of zero-filled subarrays
  zeros = 0   # This keeps track of the current sequence of consecutive zeros

  # Iterate through each number in the array
  nums.each do |num|
    if num == 0
      # If the current number is 0, increment the zero streak
      zeros += 1

      # Add the current zero streak to the count
      # This accounts for all new subarrays ending at this position
      count += zeros
    else
      # If the number is not zero, reset the zero streak
      zeros = 0
    end
  end

  # Return the total count of zero-filled subarrays
  count
end
