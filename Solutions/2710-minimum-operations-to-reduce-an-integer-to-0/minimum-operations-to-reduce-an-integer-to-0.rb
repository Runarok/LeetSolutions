# @param {Integer} n
# @return {Integer}
def min_operations(n)
  steps = 0

  while n > 0
    # If n is already a power of 2
    # Example: 8, 16 → can remove in one step
    if (n & (n - 1)) == 0
      steps += 1
      break
    end

    # Get lowest set bit (rightmost 1)
    lowest_bit = n & -n

    # Option 1: subtract lowest power of 2
    subtract_option = n - lowest_bit

    # Option 2: add lowest power of 2
    add_option = n + lowest_bit

    # Choose the option that results in fewer 1s (better future)
    if subtract_option.to_s(2).count('1') < add_option.to_s(2).count('1')
      n = subtract_option
    else
      n = add_option
    end

    steps += 1
  end

  return steps
end