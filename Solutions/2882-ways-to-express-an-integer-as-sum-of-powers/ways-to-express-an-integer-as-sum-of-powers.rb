# @param {Integer} n
# @param {Integer} x
# @return {Integer}
def number_of_ways(n, x)
  mod = 1_000_000_007

  # Initialize a dp array of size n+1 with all elements as 0
  # dp[i] will store the number of ways to form sum i using powers
  dp = Array.new(n + 1, 0)

  # There's 1 way to form sum 0 — by choosing nothing
  dp[0] = 1

  # Iterate over base numbers (1 to n)
  (1..n).each do |i|
    # Calculate i raised to the power of x
    val = i**x

    # If val is greater than n, no point in proceeding further
    break if val > n

    # Iterate backwards from n to val
    # This ensures that each power is only used once per combination
    (n).downto(val) do |j|
      dp[j] = (dp[j] + dp[j - val]) % mod
    end
  end

  # The answer is the number of ways to form the sum n
  dp[n]
end
