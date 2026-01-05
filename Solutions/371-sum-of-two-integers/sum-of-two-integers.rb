# Function to calculate the sum of two integers without using + or -
# Works safely for both positive and negative integers
# @param {Integer} a - first integer
# @param {Integer} b - second integer
# @return {Integer} - sum of a and b
def get_sum(a, b)
  # Mask to simulate 32-bit integer overflow
  mask = 0xFFFFFFFF
  
  # Loop until there is no carry
  while b != 0
    # XOR gives sum without carry
    sum_without_carry = (a ^ b) & mask
    
    # AND + shift gives the carry
    carry = ((a & b) << 1) & mask
    
    # Update a and b for next iteration
    a = sum_without_carry
    b = carry
  end
  
  # Handle negative numbers
  # If the 32nd bit is set, interpret as negative
  if a >> 31 == 1
    return ~(a ^ mask)  # Convert to negative number
  else
    return a
  end
end
