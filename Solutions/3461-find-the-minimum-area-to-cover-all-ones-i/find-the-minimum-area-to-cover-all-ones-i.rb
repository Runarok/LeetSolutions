# @param {Integer[][]} grid
# @return {Integer}
def minimum_area(grid)
  # Get number of rows and columns in the grid
  rows = grid.length
  cols = grid[0].length

  # Initialize boundary coordinates for the rectangle
  min_row = rows       # Smallest row index containing a 1 (initialize to max possible)
  max_row = -1         # Largest row index containing a 1 (initialize to min possible)
  min_col = cols       # Smallest column index containing a 1 (initialize to max possible)
  max_col = -1         # Largest column index containing a 1 (initialize to min possible)

  # Traverse the entire grid to find the extreme positions of all 1's
  (0...rows).each do |i|
    (0...cols).each do |j|
      if grid[i][j] == 1
        # Update boundaries whenever a 1 is found
        min_row = [min_row, i].min
        max_row = [max_row, i].max
        min_col = [min_col, j].min
        max_col = [max_col, j].max
      end
    end
  end

  # Compute height and width of the rectangle
  height = max_row - min_row + 1
  width = max_col - min_col + 1

  # Return area (height * width)
  return height * width
end
