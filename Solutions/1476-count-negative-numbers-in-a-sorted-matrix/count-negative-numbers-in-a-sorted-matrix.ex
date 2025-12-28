defmodule Solution do
  @spec count_negatives(grid :: [[integer]]) :: integer
  def count_negatives(grid) do
    # Number of rows (m)
    m = length(grid)

    # Number of columns (n)
    n = length(hd(grid))

    # Start at the top-right corner
    row = 0
    col = n - 1

    # Accumulator for negative numbers
    count = 0

    # Traverse while we are inside the grid
    count_negatives(grid, row, col, m, count)
  end

  # Base case:
  # If we've gone past the last row or before the first column,
  # stop and return the accumulated count
  defp count_negatives(_grid, row, col, m, count)
       when row >= m or col < 0 do
    count
  end

  defp count_negatives(grid, row, col, m, count) do
    # Get the current value at (row, col)
    value = grid |> Enum.at(row) |> Enum.at(col)

    if value < 0 do
      # If the value is negative:
      # All elements below this one in the same column are also negative
      # Count how many rows remain (including current row)
      negatives_in_column = m - row

      # Move left to the next column
      count_negatives(
        grid,
        row,
        col - 1,
        m,
        count + negatives_in_column
      )
    else
      # If the value is non-negative:
      # Move down to the next row
      count_negatives(grid, row + 1, col, m, count)
    end
  end
end
