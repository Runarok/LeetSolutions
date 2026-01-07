# @param {Integer} n
# @param {Integer} min_profit
# @param {Integer[]} group
# @param {Integer[]} profit
# @return {Integer}
def profitable_schemes(n, min_profit, group, profit)
  mod = 1_000_000_007

  # dp[i][p] = number of schemes using i members and profit p
  dp = Array.new(n + 1) { Array.new(min_profit + 1, 0) }

  # Base case: 0 members, 0 profit → 1 way (do nothing)
  dp[0][0] = 1

  group.each_with_index do |g, idx|
    p = profit[idx]

    # Update dp in reverse to avoid overwriting
    n.downto(g) do |i|
      min_profit.downto(0) do |j|
        # New profit after adding current crime
        new_profit = [j + p, min_profit].min
        dp[i][new_profit] = (dp[i][new_profit] + dp[i - g][j]) % mod
      end
    end
  end

  # Sum all schemes with profit >= minProfit using any number of members
  (0..n).sum { |i| dp[i][min_profit] } % mod
end
