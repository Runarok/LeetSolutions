# Function to generate an n-bit Gray code sequence
# @param {Integer} n - number of bits
# @return {Integer[]} - an array containing the Gray code sequence
def gray_code(n)
  # Initialize the result array with the first Gray code number: 0
  # Gray codes always start with 0
  result = [0]

  # Loop over the number of bits from 0 to n-1
  # This approach uses the "mirror method" to generate Gray codes
  # Idea: 
  # 1-bit Gray code: [0,1]
  # 2-bit Gray code: prefix 0 to previous sequence, then prefix 1 to reversed previous sequence
  # 3-bit Gray code: prefix 0 to 2-bit sequence, prefix 1 to reversed 2-bit sequence, and so on
  (0...n).each do |i|
    # Calculate the value to add to the mirrored half
    # This is 2^i (1 << i) which sets the ith bit to 1
    add_on = 1 << i
    
    # Mirror the current sequence in reverse order
    # This ensures that only one bit changes between the last element of the original sequence
    # and the first element of the mirrored part
    result.reverse_each do |x|
      # Add add_on to the mirrored value and append to result
      result << x + add_on
    end
  end

  # Return the complete Gray code sequence
  return result
end