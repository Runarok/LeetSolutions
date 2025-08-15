# @param {Integer} n
# @return {Boolean}
def is_power_of_four(n)
  # Step 1: Any power of four must be a positive number
  return false if n <= 0

  # Step 2: Check if n is a power of two.
  # A number is a power of two if it has exactly one bit set in its binary representation.
  # For example:
  #   4  -> 100
  #   8  -> 1000
  #   16 -> 10000
  # The trick (n & (n - 1)) == 0 checks if only one bit is set.
  # If more than one bit is set, (n & (n - 1)) will not be zero.
  is_power_of_two = (n & (n - 1)) == 0

  # Step 3: If n is a power of two, we now check if that one bit is in the correct position.
  # Specifically, the set bit must be in an even position (0-based).
  # That’s the property of powers of 4:
  #   1  -> 0001 (bit at position 0) -> 4^0
  #   4  -> 0100 (bit at position 2) -> 4^1
  #   16 -> 0001_0000 (bit at position 4) -> 4^2
  #   etc.

  # 0x55555555 is a hexadecimal number with binary pattern:
  #   01010101010101010101010101010101
  # It has 1s in all even positions (bit index: 0, 2, 4, ...).
  # By doing (n & 0x55555555), we're checking if the single set bit is in one of those even positions.
  is_even_position = (n & 0x55555555) != 0

  # Step 4: Return true only if both conditions are satisfied:
  # - n is a power of two
  # - The bit is in an even position (which makes it a power of four)
  return is_power_of_two && is_even_position
end
