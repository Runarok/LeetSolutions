defmodule Solution do
  @spec projection_area(grid :: [[integer]]) :: integer
  def projection_area(grid) do
    # Top-down projection (xy-plane)
    # Count of non-zero cells
    xy = Enum.reduce(grid, 0, fn row, acc ->
      acc + Enum.count(row, fn v -> v > 0 end)
    end)

    # Side projection (zx-plane)
    # Max of each row
    zx = Enum.reduce(grid, 0, fn row, acc ->
      acc + Enum.max(row)
    end)

    # Front projection (yz-plane)
    # Max of each column
    n = length(grid)
    yz = Enum.reduce(0..(n-1), 0, fn col_index, acc ->
      max_in_col = Enum.reduce(grid, 0, fn row, row_acc ->
        max(row_acc, Enum.at(row, col_index))
      end)
      acc + max_in_col
    end)

    xy + yz + zx
  end
end
