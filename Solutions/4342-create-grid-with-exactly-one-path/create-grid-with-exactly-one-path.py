class Solution:

  def createGrid(self, m: int, n: int) -> list[str]:
    """Constructs an m x n grid consisting of '.' (free cells) and '#' (obstacles)

    such that there is exactly one valid path from the top-left cell (0, 0)
    to the bottom-right cell (m - 1, n - 1), moving only right and down.

    Args:
        m (int): Number of rows in the grid (1 <= m <= 25).
        n (int): Number of columns in the grid (1 <= n <= 25).

    Returns:
        list[str]: A list of strings representing the rows of the grid.
    """

    # Step 1: Initialize the entire grid with obstacle cells ('#').
    # We will carve out our single unique path by selectively turning
    # specific cells into free cells ('.').
    grid = [["#" for _ in range(n)] for _ in range(m)]

    # Step 2: Handle the base edge case where the grid is 1x1.
    # A single-cell grid trivially has exactly one path (itself).
    if m == 1 and n == 1:
      return ["."]

    # Step 3: Track the current column where our path descends to the next row.
    current_col = 0

    # Step 4: Iterate through all rows except the last one (from r = 0 to m - 2).
    # This creates a staircase/zigzag corridor that forces the path downward
    # one row at a time with only one possible choice at each junction.
    for r in range(m - 1):
      # Make the current cell in this row free ('.')
      grid[r][current_col] = "."

      # If we can still move further to the right in the current row,
      # open up the adjacent cell to allow moving right before going down.
      if current_col + 1 < n:
        grid[r][current_col + 1] = "."
        # Shift our tracking column pointer to the right
        current_col += 1

    # Step 5: Fill the remaining cells in the final row (m - 1)
    # starting from our last column position all the way to the end of the row (n - 1).
    # This ensures the path can successfully reach the bottom-right corner (m - 1, n - 1).
    for c in range(current_col, n):
      grid[m - 1][c] = "."

    # Step 6: Convert the 2D list of characters into a list of strings
    # as required by the return type `list[str]`.
    return ["".join(row) for row in grid]