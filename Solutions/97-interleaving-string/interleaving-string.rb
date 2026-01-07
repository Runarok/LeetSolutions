# @param {String} s1
# @param {String} s2
# @param {String} s3
# @return {Boolean}
def is_interleave(s1, s2, s3)
  m = s1.length
  n = s2.length

  # Quick check: total length must match
  return false if m + n != s3.length

  # dp[j] = true if s3[0..i+j-1] can be formed by interleaving
  # s1[0..i-1] and s2[0..j-1]
  dp = Array.new(n + 1, false)

  # Initialize first row (i=0) — using only s2
  (0..n).each do |j|
    dp[j] = j == 0 ? true : (dp[j - 1] && s2[j - 1] == s3[j - 1])
  end

  # Fill dp for each character of s1
  (1..m).each do |i|
    # First column (j=0) — only s1 characters
    dp[0] = dp[0] && s1[i - 1] == s3[i - 1]

    # Fill rest of the row
    (1..n).each do |j|
      dp[j] = (dp[j] && s1[i - 1] == s3[i + j - 1]) ||  # take from s1
              (dp[j - 1] && s2[j - 1] == s3[i + j - 1])  # take from s2
    end
  end

  # Final answer: can full s1 and s2 form full s3?
  dp[n]
end
