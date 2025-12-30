defmodule Solution do
  @spec num_magic_squares_inside(grid :: [[integer]]) :: integer
  def num_magic_squares_inside(grid) do
    # Number of rows in the grid
    rows = length(grid)

    # Number of columns in the grid
    # We can safely use hd(grid) because constraints guarantee at least 1 row
    cols = length(hd(grid))

    # A 3x3 magic square cannot exist if either dimension is smaller than 3
    if rows < 3 or cols < 3 do
      # Not enough space → return 0 immediately
      0
    else
      # We slide a 3x3 "window" across the grid
      # i = starting row of the subgrid
      # j = starting column of the subgrid
      for i <- 0..(rows - 3),
          j <- 0..(cols - 3),

          # Only keep subgrids that are magic squares
          magic_square?(grid, i, j),

          # Reduce accumulates the count
          reduce: 0 do
        acc ->
          # Every valid magic square increases the count by 1
          acc + 1
      end
    end
  end

  # -------------------------------------------------------------
  # Checks whether the 3x3 subgrid starting at (row, col) is magic
  # -------------------------------------------------------------
  defp magic_square?(grid, row, col) do
    # Extract all 9 values from the 3x3 subgrid
    # This flattens the square into a list
    values =
      for r <- row..(row + 2),
          c <- col..(col + 2) do
        grid |> Enum.at(r) |> Enum.at(c)
      end

    # A valid magic square must contain EXACTLY the numbers 1..9
    # No duplicates, no missing values, no extra values
    if Enum.sort(values) != Enum.to_list(1..9) do
      false
    else
      # -------------------------
      # Extract the three rows
      # -------------------------
      r1 = get_row(grid, row, col)
      r2 = get_row(grid, row + 1, col)
      r3 = get_row(grid, row + 2, col)

      # -------------------------
      # Extract the three columns
      # -------------------------
      c1 = get_col(grid, row, col)
      c2 = get_col(grid, row, col + 1)
      c3 = get_col(grid, row, col + 2)

      # -------------------------
      # Extract both diagonals
      # -------------------------
      # Top-left → bottom-right diagonal
      d1 = [
        grid |> Enum.at(row) |> Enum.at(col),
        grid |> Enum.at(row + 1) |> Enum.at(col + 1),
        grid |> Enum.at(row + 2) |> Enum.at(col + 2)
      ]

      # Top-right → bottom-left diagonal
      d2 = [
        grid |> Enum.at(row) |> Enum.at(col + 2),
        grid |> Enum.at(row + 1) |> Enum.at(col + 1),
        grid |> Enum.at(row + 2) |> Enum.at(col)
      ]

      # Combine all rows, columns, and diagonals into one list
      lines = [r1, r2, r3, c1, c2, c3, d1, d2]

      # Convert each row/column/diagonal into its sum
      sums = Enum.map(lines, &Enum.sum/1)

      # In a 3x3 magic square using 1..9, every sum must be exactly 15
      Enum.all?(sums, fn sum -> sum == 15 end)
    end
  end

  # -------------------------------------------------------------
  # Returns 3 consecutive values from a specific row
  # -------------------------------------------------------------
  defp get_row(grid, row, col) do
    grid
    |> Enum.at(row)      # get the full row
    |> Enum.slice(col, 3) # take 3 values starting at column "col"
  end

  # -------------------------------------------------------------
  # Returns 3 values from a specific column
  # -------------------------------------------------------------
  defp get_col(grid, row, col) do
    [
      grid |> Enum.at(row) |> Enum.at(col),
      grid |> Enum.at(row + 1) |> Enum.at(col),
      grid |> Enum.at(row + 2) |> Enum.at(col)
    ]
  end
end
