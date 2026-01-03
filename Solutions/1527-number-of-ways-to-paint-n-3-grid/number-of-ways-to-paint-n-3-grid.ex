defmodule Solution do
  @mod 1_000_000_007

  @spec num_of_ways(n :: integer) :: integer
  def num_of_ways(n) do
    # Base case:
    # For n = 1
    # Type A (ABA): 6 ways
    # Type B (ABC): 6 ways
    a = 6
    b = 6

    # If there's only one row, return total immediately
    if n == 1 do
      rem(a + b, @mod)
    else
      # Iterate from row 2 to row n
      {final_a, final_b} =
        Enum.reduce(2..n, {a, b}, fn _, {prev_a, prev_b} ->
          # Calculate new values using transition rules
          new_a =
            (3 * prev_a + 2 * prev_b)
            |> rem(@mod)

          new_b =
            (2 * prev_a + 2 * prev_b)
            |> rem(@mod)

          # Return updated state for next iteration
          {new_a, new_b}
        end)

      # Total ways = Type A + Type B
      rem(final_a + final_b, @mod)
    end
  end
end
