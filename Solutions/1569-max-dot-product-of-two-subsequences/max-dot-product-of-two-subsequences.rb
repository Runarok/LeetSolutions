# @param {Integer[]} nums1
# @param {Integer[]} nums2
# @return {Integer}
def max_dot_product(nums1, nums2)
  n = nums1.length
  m = nums2.length

  # Initialize dp table with very small values
  dp = Array.new(n + 1) { Array.new(m + 1, -Float::INFINITY) }

  # Base case:
  # Using empty subsequences is invalid, but this helps transitions
  dp[0][0] = -Float::INFINITY

  (1..n).each do |i|
    (1..m).each do |j|
      product = nums1[i - 1] * nums2[j - 1]

      dp[i][j] = [
        product,                       # start new subsequence
        dp[i - 1][j - 1] + product,    # extend previous subsequence
        dp[i - 1][j],                  # skip nums1[i-1]
        dp[i][j - 1]                   # skip nums2[j-1]
      ].max
    end
  end

  dp[n][m]
end
