defmodule Solution do
  @spec smallest_repunit_div_by_k(k :: integer) :: integer
  def smallest_repunit_div_by_k(k) do
    # ------------------------------------------------------------
    # STEP 1: Quick rejection
    # ------------------------------------------------------------
    # If k is divisible by 2 or 5, it is IMPOSSIBLE
    # for a number made only of '1's to be divisible by k
    if rem(k, 2) == 0 or rem(k, 5) == 0 do
      -1
    else
      # ------------------------------------------------------------
      # STEP 2: Iterate using modulo arithmetic
      # ------------------------------------------------------------
      # remainder -> current remainder modulo k
      # length    -> length of the repunit number so far
      #
      # Start with:
      # n = 1
      # remainder = 1 % k
      iterate(k, 1, rem(1, k))
    end
  end

  # ------------------------------------------------------------
  # Helper recursive function
  # ------------------------------------------------------------
  defp iterate(_k, length, 0) do
    # ------------------------------------------------------------
    # If remainder becomes 0, we found our answer
    # ------------------------------------------------------------
    length
  end

  defp iterate(k, length, remainder) do
    # ------------------------------------------------------------
    # Pigeonhole Principle:
    # There are only k possible remainders (0 to k-1)
    # If we haven't hit 0 after k steps, we never will
    # ------------------------------------------------------------
    if length > k do
      -1
    else
      # ------------------------------------------------------------
      # Build the next repunit remainder
      #
      # new_number = previous_number * 10 + 1
      # new_remainder = (remainder * 10 + 1) mod k
      # ------------------------------------------------------------
      new_remainder = rem(remainder * 10 + 1, k)

      iterate(k, length + 1, new_remainder)
    end
  end
end
