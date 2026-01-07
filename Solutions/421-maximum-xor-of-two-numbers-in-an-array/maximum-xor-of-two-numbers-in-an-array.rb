# Function to find the maximum XOR of two numbers in nums
def find_maximum_xor(nums)
  max_xor = 0     # Initialize maximum XOR
  mask = 0        # Mask to consider prefixes bit by bit

  # We have 32-bit integers (0 <= nums[i] <= 2^31 - 1)
  31.downto(0) do |i|
    mask |= (1 << i)           # Add current bit to mask
    prefixes = Set.new

    # Store all prefixes of length (32 - i) bits
    nums.each do |num|
      prefixes.add(num & mask)
    end

    # Try to greedily set the current bit in max_xor
    candidate = max_xor | (1 << i)
    found = false

    prefixes.each do |p|
      # If there exists a pair of prefixes that XOR to candidate
      if prefixes.include?(p ^ candidate)
        found = true
        break
      end
    end

    max_xor = candidate if found
  end

  max_xor
end
