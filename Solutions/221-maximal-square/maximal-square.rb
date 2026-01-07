# Maximal Square in a binary matrix
# Return the area of the largest square of 1's

def maximal_square(matrix)
  
  # edge case: empty matrix
  return 0 if matrix.empty? || matrix[0].empty?
  
  m = matrix.size
  n = matrix[0].size
  
  # DP table with extra row/column
  # dp[i][j] = side length of largest square ending at (i-1,j-1)
  dp = Array.new(m + 1) { Array.new(n + 1, 0) }
  
  max_side = 0   # track max square side
  
  # iterate through matrix
  (1..m).each do |i|
    (1..n).each do |j|
      
      # only if current cell is '1'
      if matrix[i - 1][j - 1] == '1'
        
        # DP recurrence: min of top, left, top-left + 1
        dp[i][j] = [dp[i-1][j], dp[i][j-1], dp[i-1][j-1]].min + 1
        
        # update max side
        max_side = [max_side, dp[i][j]].max
      end
    end
  end
  
  # return area
  max_side * max_side
end
