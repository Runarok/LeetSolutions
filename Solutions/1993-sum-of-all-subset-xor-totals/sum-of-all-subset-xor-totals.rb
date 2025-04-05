# Method to calculate the sum of XOR totals for all subsets of the given array
# @param {Integer[]} nums - An array of integers
# @return {Integer} - The sum of XOR totals for all subsets
def subset_xor_sum(nums)
  n = nums.length  # Get the number of elements in the array
  total = 0        # Initialize the total sum of XORs

  # Loop through all possible subsets using bit masking
  # There are 2^n possible subsets for an array of size n
  (0...1 << n).each do |mask|
    xor_sum = 0    # XOR sum for the current subset
    
    # Loop through each bit in the mask to check which elements are included
    (0...n).each do |i|
      # Check if the i-th bit in mask is set (indicates inclusion of nums[i])
      if (mask & (1 << i)) != 0
        xor_sum ^= nums[i]  # XOR the current element with xor_sum
      end
    end

    # Add the XOR sum of the current subset to the total sum
    total += xor_sum
  end

  # Return the final total sum after processing all subsets
  total
end
