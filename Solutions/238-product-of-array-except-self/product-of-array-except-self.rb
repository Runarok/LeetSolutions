# @param {Integer[]} nums
# @return {Integer[]}
def product_except_self(nums)
  n = nums.length
  
  # This will store the final result
  answer = Array.new(n, 1)

  # -----------------------------
  # First pass (LEFT → RIGHT)
  # -----------------------------
  # answer[i] will contain product of all elements to the LEFT of i
  left_product = 1
  
  (0...n).each do |i|
    # Store product of all elements before index i
    answer[i] = left_product
    
    # Update left_product for next index
    left_product *= nums[i]
  end

  # -----------------------------
  # Second pass (RIGHT → LEFT)
  # -----------------------------
  # Multiply with product of all elements to the RIGHT of i
  right_product = 1
  
  (n - 1).downto(0) do |i|
    # Multiply existing left product with right product
    answer[i] *= right_product
    
    # Update right_product for next iteration
    right_product *= nums[i]
  end

  return answer
end