defmodule Solution do
  @spec generate(num_rows :: integer) :: [[integer]]
  def generate(num_rows) when num_rows >= 1 do
    generate_rows(num_rows, [])
    |> Enum.reverse()
  end

  # Helper function to build rows recursively
  defp generate_rows(0, acc), do: acc

  defp generate_rows(n, []) do
    # First row is always [1]
    generate_rows(n - 1, [[1]])
  end

  defp generate_rows(n, [prev_row | _] = acc) do
    # Build the next row
    next_row =
      [0 | prev_row]
      |> Enum.zip(prev_row ++ [0])
      |> Enum.map(fn {a, b} -> a + b end)

    generate_rows(n - 1, [next_row | acc])
  end
end
