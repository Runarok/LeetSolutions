# @param {Integer[][]} mat
# @return {Integer}
def num_submat(mat)
  m = mat.length               # Number of rows
  n = mat[0].length            # Number of columns
  res = 0                      # Final result to store the count of submatrices
  row = Array.new(m) { Array.new(n, 0) }  # Preprocessed matrix to store row-wise prefix sums

  # Preprocess each row to count consecutive 1s to the left (including itself)
  (0...m).each do |i|
    (0...n).each do |j|
      if j == 0
        row[i][j] = mat[i][j]
      else
        row[i][j] = (mat[i][j] == 0) ? 0 : row[i][j - 1] + 1
      end

      cur = row[i][j]  # The current width of continuous 1s ending at (i,j)

      # Check all rows above including current, for possible submatrices ending at (i,j)
      k = i
      while k >= 0 && cur > 0
        cur = [cur, row[k][j]].min  # Limit width to the smallest width above
        res += cur                 # Add the number of submatrices with width `cur` ending at row k
        k -= 1
      end
    end
  end

  return res
end
