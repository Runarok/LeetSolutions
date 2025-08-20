# @param {Integer[][]} matrix
# @return {Integer}
def count_squares(matrix)
  # Get number of rows (m) and columns (n)
  m = matrix.length
  n = matrix[0].length

  # Create a DP table of the same size as the input matrix
  # dp[i][j] will store the size of the largest square that ends at cell (i, j)
  dp = Array.new(m) { Array.new(n, 0) }

  # Variable to keep track of total number of square submatrices with all ones
  total = 0

  # Iterate through each cell in the matrix
  for i in 0...m
    for j in 0...n
      # Only process if the current cell is 1
      if matrix[i][j] == 1
        # If we are at the first row or first column, the largest square is just 1
        if i == 0 || j == 0
          dp[i][j] = 1
        else
          # Check the three neighboring cells:
          # Top (dp[i-1][j]), Left (dp[i][j-1]), Top-left diagonal (dp[i-1][j-1])
          # The minimum of these three determines the largest square we can build
          dp[i][j] = 1 + [dp[i-1][j], dp[i][j-1], dp[i-1][j-1]].min
        end

        # Add the size of the square at (i, j) to the total count
        # Why? Because if dp[i][j] == 3, that means this cell contributes:
        # - one 1x1 square
        # - one 2x2 square
        # - one 3x3 square
        total += dp[i][j]
      end
      # If the cell is 0, no square can end here — dp[i][j] stays 0
    end
  end

  # Return the total number of square submatrices with all ones
  return total
end
