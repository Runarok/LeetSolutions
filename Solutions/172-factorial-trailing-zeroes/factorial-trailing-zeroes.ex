defmodule Solution do
  @spec trailing_zeroes(n :: integer) :: integer
  def trailing_zeroes(n) do
    # Step 1: Initialize count of trailing zeroes
    count = 0

    # Step 2: Start with the first power of 5
    power_of_5 = 5

    # Step 3: Loop until n / power_of_5 is zero
    # Each division counts how many numbers <= n are multiples of this power of 5
    # These contribute to trailing zeros
    while_loop(count, power_of_5, n)
  end

  # Helper recursive function to mimic a while loop
  defp while_loop(count, power_of_5, n) when div(n, power_of_5) > 0 do
    # How many multiples of current power of 5 in n
    multiples = div(n, power_of_5)

    # Add them to the count
    count = count + multiples

    # Move to the next power of 5
    while_loop(count, power_of_5 * 5, n)
  end

  # Base case: no more multiples, return final count
  defp while_loop(count, _power_of_5, _n), do: count
end
