# @param {String} s1
# @param {String} s2
# @return {Integer}
def minimum_delete_sum(s1, s2)
  n = s1.length
  m = s2.length

  # dp[i][j] = maximum ASCII sum of common subsequence
  # between s1[0...i-1] and s2[0...j-1]
  dp = Array.new(n + 1) { Array.new(m + 1, 0) }

  # Build the DP table
  (1..n).each do |i|
    (1..m).each do |j|
      if s1[i - 1] == s2[j - 1]
        # Characters match → include ASCII value
        dp[i][j] = dp[i - 1][j - 1] + s1[i - 1].ord
      else
        # Characters don't match → take the best option
        dp[i][j] = [dp[i - 1][j], dp[i][j - 1]].max
      end
    end
  end

  # Total ASCII sum of all characters in both strings
  total_sum = s1.each_char.sum(&:ord) + s2.each_char.sum(&:ord)

  # Subtract twice the ASCII sum of the kept common subsequence
  total_sum - 2 * dp[n][m]
end
