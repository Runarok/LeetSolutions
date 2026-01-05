defmodule Solution do
  # Import bitwise operators so we can use &&& (AND), <<<, >>>, etc.
  import Bitwise

  @spec hamming_weight(n :: integer) :: integer
  def hamming_weight(n) do
    # Initialize count of set bits to 0
    count = 0

    # Use a recursive helper function to count set bits
    count = do_hamming(n, count)

    count
  end

  # Base case: if n is 0, return the count
  defp do_hamming(0, count), do: count

  # Recursive case: remove the lowest set bit and increment count
  defp do_hamming(n, count) do
    # Remove the lowest set bit using Brian Kernighan's trick
    n = n &&& (n - 1)

    # Recurse with incremented count
    do_hamming(n, count + 1)
  end
end
