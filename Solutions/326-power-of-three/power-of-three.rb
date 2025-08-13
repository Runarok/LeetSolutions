# @param {Integer} n
# @return {Boolean}
def is_power_of_three(n)
  # Any non-positive number (zero or negative) cannot be a power of 3
  return false if n <= 0

  # 3^19 = 1162261467 is the largest power of 3 that fits in a 32-bit signed integer.
  # If n is a power of 3, then it must divide 1162261467 evenly.
  return 1162261467 % n == 0
end
