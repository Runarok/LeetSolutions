defmodule Solution do
  @spec sum_four_divisors(nums :: [integer]) :: integer
  def sum_four_divisors(nums) do
    # We go through each number in the list
    # and accumulate the total sum of divisors
    Enum.reduce(nums, 0, fn num, acc ->
      # Get the sum of divisors if the number has exactly 4 divisors
      # Otherwise, this function returns 0
      acc + sum_if_four_divisors(num)
    end)
  end

  # Helper function:
  # Returns the sum of divisors if `n` has exactly 4 divisors
  # Otherwise returns 0
  defp sum_if_four_divisors(n) do
    # 1 can never have 4 divisors
    if n <= 1 do
      0
    else
      # We start with divisor 1 and the number itself
      # These always exist
      divisors = MapSet.new([1, n])

      # We only need to check up to sqrt(n)
      limit = :math.sqrt(n) |> floor()

      # We try to find divisor pairs
      divisors =
        Enum.reduce_while(2..limit, divisors, fn i, divs ->
          if rem(n, i) == 0 do
            # i is a divisor
            # n / i is also a divisor
            new_divs = divs |> MapSet.put(i) |> MapSet.put(div(n, i))

            # If we already have more than 4 divisors,
            # we can stop early (not valid anymore)
            if MapSet.size(new_divs) > 4 do
              {:halt, new_divs}
            else
              {:cont, new_divs}
            end
          else
            {:cont, divs}
          end
        end)

      # After collecting divisors,
      # check if we have exactly 4
      if MapSet.size(divisors) == 4 do
        # Sum all divisors
        Enum.sum(divisors)
      else
        0
      end
    end
  end
end
