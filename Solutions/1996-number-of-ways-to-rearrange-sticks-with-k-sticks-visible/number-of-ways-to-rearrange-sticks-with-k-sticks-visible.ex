defmodule Solution do
  @mod 1_000_000_007

  @spec rearrange_sticks(n :: integer, k :: integer) :: integer
  def rearrange_sticks(n, k) do
    # DP tuples: prev[j] = ways to arrange i-1 sticks with j visible
    prev = :erlang.make_tuple(k + 1, 0)
    prev = put_elem(prev, 0, 1) # base case: 0 sticks, 0 visible

    # Loop over sticks from 1 to n
    final =
      Enum.reduce(1..n, prev, fn i, prev ->
        # New DP tuple for i sticks
        curr = :erlang.make_tuple(k + 1, 0)

        curr =
          Enum.reduce(1..min(i, k), curr, fn j, curr ->
            val =
              (elem(prev, j - 1) + (i - 1) * elem(prev, j))
              |> rem(@mod)

            put_elem(curr, j, val)
          end)

        curr
      end)

    elem(final, k)
  end
end
